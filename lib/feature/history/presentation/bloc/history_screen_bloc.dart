import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qr_scanner_practice/core/services/network/failure.dart';
import 'package:qr_scanner_practice/feature/history/domain/usecase/get_history_scans_use_case.dart';
import 'package:qr_scanner_practice/feature/result_scan/domain/entity/pending_sync_entity.dart';

part 'history_screen_event.dart';

part 'history_screen_state.dart';

class HistoryScreenBloc extends Bloc<HistoryScreenEvent, HistoryScreenState> {
  HistoryScreenBloc({required this.getHistoryScansUseCase})
    : super(const HistoryScreenInitial()) {
    on<OnHistoryLoadScans>(_onLoadScans);
    on<OnHistorySearchScans>(_onSearchScans);
    on<OnHistoryRefreshScans>(_onRefreshScans);
  }

  final GetHistoryScansUseCase getHistoryScansUseCase;

  Future<void> _onLoadScans(
    final OnHistoryLoadScans event,
    final Emitter<HistoryScreenState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final Either<Failure, List<PendingSyncEntity>> result =
        await getHistoryScansUseCase();

    await result.fold(
      (final Failure failure) {
        emit(state.copyWith(isLoading: false, error: failure.message));
      },
      (final List<PendingSyncEntity> scans) {
        emit(
          state.copyWith(
            isLoading: false,
            allScans: scans,
            filteredScans: scans,
          ),
        );
      },
    );
  }

  void _onSearchScans(
    final OnHistorySearchScans event,
    final Emitter<HistoryScreenState> emit,
  ) {
    final String query = event.query.toLowerCase();

    if (query.isEmpty) {
      emit(state.copyWith(filteredScans: state.allScans, searchQuery: ''));
      return;
    }

    final List<PendingSyncEntity> filtered = state.allScans.where((
      final PendingSyncEntity item,
    ) {
      final String qrDataLower = item.scan.data.toLowerCase();
      final String commentLower = item.scan.comment.toLowerCase();
      final String sheetTitleLower = item.sheetTitle.toLowerCase();

      return qrDataLower.contains(query) ||
          commentLower.contains(query) ||
          sheetTitleLower.contains(query);
    }).toList();

    emit(state.copyWith(filteredScans: filtered, searchQuery: query));
  }

  Future<void> _onRefreshScans(
    final OnHistoryRefreshScans event,
    final Emitter<HistoryScreenState> emit,
  ) async {
    emit(state.copyWith(isRefreshing: true));

    final Either<Failure, List<PendingSyncEntity>> result =
        await getHistoryScansUseCase();

    await result.fold(
      (final Failure failure) {
        emit(state.copyWith(isRefreshing: false, error: failure.message));
      },
      (final List<PendingSyncEntity> scans) {
        emit(
          state.copyWith(
            isRefreshing: false,
            allScans: scans,
            filteredScans: scans,
            searchQuery: '',
          ),
        );
      },
    );
  }
}
