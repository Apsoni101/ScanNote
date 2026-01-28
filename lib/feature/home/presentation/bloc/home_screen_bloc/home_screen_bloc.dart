import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:qr_scanner_practice/core/services/connectivity_service.dart';
import 'package:qr_scanner_practice/feature/home/domain/use_case/home_screen_use_case.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/pending_sync_entity.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/result_scan_entity.dart';

part 'home_screen_event.dart';

part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc({required this.useCase, required this.connectivityService})
    : super(const HomeScreenInitial()) {
    on<OnHomeLoadInitial>(_onLoadInitial);
    on<OnHomeSyncPendingScans>(_onSyncPendingScans);
    on<OnHomeNetworkStatusChanged>(_onNetworkStatusChanged);
    on<OnHomeResetSyncSuccess>(_onResetSyncSuccess);
    on<OnHomeResetSyncError>(_onResetSyncError);
    on<OnHomeResetError>(_onResetError);
    on<OnHomeUpdatePendingCount>(_onUpdatePendingCount);

    _connectivitySubscription = connectivityService
        .onConnectivityChanged()
        .listen((final bool isOnline) {
          add(OnHomeNetworkStatusChanged(isConnected: isOnline));
        });
  }

  final HomeScreenUseCase useCase;
  final ConnectivityService connectivityService;

  late final StreamSubscription<bool> _connectivitySubscription;

  Future<void> _onLoadInitial(
    final OnHomeLoadInitial event,
    final Emitter<HomeScreenState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final bool isOnline = await connectivityService.hasInternetConnection();

    final Either<Failure, List<PendingSyncEntity>> pendingResult = await useCase
        .getPendingSyncScans();

    await pendingResult.fold(
      (final Failure failure) async {
        emit(state.copyWith(isLoading: false, error: failure.message));
      },
      (final List<PendingSyncEntity> syncs) async {
        final int pendingCount = syncs.length;

        emit(
          state.copyWith(
            isLoading: false,
            isOnline: isOnline,
            pendingSyncCount: pendingCount,
          ),
        );

        if (isOnline && pendingCount > 0) {
          add(const OnHomeSyncPendingScans());
        }
      },
    );
  }

  Future<void> _onSyncPendingScans(
    final OnHomeSyncPendingScans event,
    final Emitter<HomeScreenState> emit,
  ) async {
    final bool isOnline = await connectivityService.hasInternetConnection();

    if (!isOnline) {
      emit(
        state.copyWith(
          syncError: 'No internet connection. Scans will sync when online.',
          isOnline: false,
        ),
      );
      return;
    }

    emit(state.copyWith(isSyncing: true, isOnline: true));

    final Either<Failure, List<PendingSyncEntity>> pendingResult = await useCase
        .getPendingSyncScans();

    await pendingResult.fold(
      (final Failure failure) async {
        emit(state.copyWith(isSyncing: false, syncError: failure.message));
      },
      (final List<PendingSyncEntity> pendingSyncs) async {
        if (pendingSyncs.isEmpty) {
          emit(
            state.copyWith(
              isSyncing: false,
              pendingSyncCount: 0,
              showSyncSuccess: true,
            ),
          );
          return;
        }

        int syncedCount = 0;
        String? lastError;

        for (int i = 0; i < pendingSyncs.length; i++) {
          final PendingSyncEntity pendingSync = pendingSyncs[i];
          final ScanResultEntity scan = pendingSync.scan;
          final String sheetId = pendingSync.sheetId;

          final Either<Failure, Unit> result = await useCase.saveScan(
            scan,
            sheetId,
          );

          await result.fold(
            (final Failure failure) async {
              final bool isSheetNotFoundError = _isSheetNotFoundError(failure);

              if (isSheetNotFoundError) {
                final Either<Failure, String> createResult = await useCase
                    .createSheet(pendingSync.sheetTitle);

                await createResult.fold(
                  (final Failure createFailure) {
                    lastError = createFailure.message;
                  },
                  (final String newSheetId) async {
                    final Either<Failure, Unit> retrySaveResult = await useCase
                        .saveScan(scan, newSheetId);

                    await retrySaveResult.fold(
                      (final Failure retryFailure) {
                        lastError = retryFailure.message;
                      },
                      (_) async {
                        syncedCount++;
                        await useCase.removeSyncedScan(i);
                      },
                    );
                  },
                );
              } else {
                lastError = failure.message;
              }
            },
            (_) async {
              syncedCount++;
              await useCase.removeSyncedScan(i);
            },
          );
        }

        final int remainingCount = pendingSyncs.length - syncedCount;

        emit(
          state.copyWith(
            isSyncing: false,
            pendingSyncCount: remainingCount,
            syncError: lastError,
            showSyncSuccess: remainingCount == 0,
            isOnline: true,
          ),
        );
      },
    );
  }

  bool _isSheetNotFoundError(final Failure failure) {
    if (failure is BadRequestFailure) {
      return failure.statusCode == '404';
    }

    final String lowerError = failure.message.toLowerCase();
    return lowerError.contains('not found') ||
        lowerError.contains('404') ||
        lowerError.contains('does not exist') ||
        (lowerError.contains('spreadsheet') && lowerError.contains('exist'));
  }

  Future<void> _onNetworkStatusChanged(
    final OnHomeNetworkStatusChanged event,
    final Emitter<HomeScreenState> emit,
  ) async {
    final bool wasOnline = state.isOnline;
    final bool isNowOnline = event.isConnected;

    final Either<Failure, List<PendingSyncEntity>> pendingResult = await useCase
        .getPendingSyncScans();

    await pendingResult.fold(
      (final Failure failure) async {
        emit(state.copyWith(isOnline: isNowOnline, error: failure.message));
      },
      (final List<PendingSyncEntity> syncs) async {
        final int pendingCount = syncs.length;

        emit(
          state.copyWith(isOnline: isNowOnline, pendingSyncCount: pendingCount),
        );

        if (isNowOnline && !wasOnline && pendingCount > 0) {
          add(const OnHomeSyncPendingScans());
        }
      },
    );
  }

  Future<void> _onUpdatePendingCount(
    final OnHomeUpdatePendingCount event,
    final Emitter<HomeScreenState> emit,
  ) async {
    final Either<Failure, List<PendingSyncEntity>> pendingResult = await useCase
        .getPendingSyncScans();

    await pendingResult.fold(
      (final Failure failure) async {
        emit(state.copyWith(error: failure.message));
      },
      (final List<PendingSyncEntity> syncs) async {
        emit(state.copyWith(pendingSyncCount: syncs.length));
      },
    );
  }

  void _onResetSyncSuccess(
    final OnHomeResetSyncSuccess event,
    final Emitter<HomeScreenState> emit,
  ) {
    emit(state.copyWith(showSyncSuccess: false));
  }

  void _onResetSyncError(
    final OnHomeResetSyncError event,
    final Emitter<HomeScreenState> emit,
  ) {
    emit(state.copyWith());
  }

  void _onResetError(
    final OnHomeResetError event,
    final Emitter<HomeScreenState> emit,
  ) {
    emit(state.copyWith());
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
