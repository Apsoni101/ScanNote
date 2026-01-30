import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/paged_sheets_entity.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/pending_sync_entity.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/result_scan_entity.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/sheet_entity.dart';
import 'package:qr_scanner_practice/feature/view_scan_history/domain/usecase/view_scans_history_remote_use_case.dart';

part 'view_scans_history_screen_event.dart';

part 'view_scans_history_screen_state.dart';

class ViewScansHistoryScreenBloc
    extends Bloc<ViewScansHistoryScreenEvent, ViewScansHistoryScreenState> {
  ViewScansHistoryScreenBloc({required this.getScansHistoryUseCase})
    : super(const HistoryScreenInitial()) {
    on<OnHistoryLoadScans>(_onLoadScans);
    on<OnHistoryLoadMoreScans>(_onLoadMoreScans);
  }

  final ViewScansHistoryRemoteUseCase getScansHistoryUseCase;

  Future<void> _onLoadScans(
    final OnHistoryLoadScans event,
    final Emitter<ViewScansHistoryScreenState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, hasMoreSheets: true));

    final Either<Failure, PagedSheetsEntity> pagedSheets =
        await getScansHistoryUseCase.getAllSheets(pageSize: 2);

    await pagedSheets.fold(
      (final Failure failure) async {
        emit(state.copyWith(isLoading: false, error: failure.message));
      },
      (final PagedSheetsEntity pagedSheetsEntity) async {
        final List<PendingSyncEntity> allScans = <PendingSyncEntity>[];

        for (final SheetEntity sheet in pagedSheetsEntity.sheets) {
          final Either<Failure, List<ScanResultEntity>> scansResult =
              await getScansHistoryUseCase.getScansFromSheet(sheet.id);

          scansResult.fold((_) {}, (final List<ScanResultEntity> scans) {
            final List<PendingSyncEntity> sheetScans = scans
                .map(
                  (final ScanResultEntity scan) => PendingSyncEntity(
                    scan: scan,
                    sheetId: sheet.id,
                    sheetTitle: sheet.title,
                  ),
                )
                .toList();
            allScans.addAll(sheetScans);
          });
        }

        emit(
          state.copyWith(
            isLoading: false,
            allScans: allScans,
            hasMoreSheets: pagedSheetsEntity.nextPageToken != null,
            nextPageToken: pagedSheetsEntity.nextPageToken,
          ),
        );
      },
    );
  }

  Future<void> _onLoadMoreScans(
    final OnHistoryLoadMoreScans event,
    final Emitter<ViewScansHistoryScreenState> emit,
  ) async {
    if (state.isLoadingMoreSheets || !state.hasMoreSheets) {
      return;
    }

    emit(state.copyWith(isLoadingMoreSheets: true));

    final Either<Failure, PagedSheetsEntity> sheetsResult =
        await getScansHistoryUseCase.getAllSheets(
          pageSize: 2,
          pageToken: state.nextPageToken,
        );

    await sheetsResult.fold(
      (final Failure failure) async {
        emit(
          state.copyWith(isLoadingMoreSheets: false, error: failure.message),
        );
      },
      (final PagedSheetsEntity pagedSheetsEntity) async {
        final List<PendingSyncEntity> newScans = <PendingSyncEntity>[];

        for (final SheetEntity sheet in pagedSheetsEntity.sheets) {
          final Either<Failure, List<ScanResultEntity>> scansResult =
              await getScansHistoryUseCase.getScansFromSheet(sheet.id);

          scansResult.fold((_) {}, (final List<ScanResultEntity> scans) {
            newScans.addAll(
              scans.map(
                (final ScanResultEntity scan) => PendingSyncEntity(
                  scan: scan,
                  sheetId: sheet.id,
                  sheetTitle: sheet.title,
                ),
              ),
            );
          });
        }

        emit(
          state.copyWith(
            isLoadingMoreSheets: false,
            allScans: .of(state.allScans)..addAll(newScans),
            hasMoreSheets: pagedSheetsEntity.nextPageToken != null,
            nextPageToken: pagedSheetsEntity.nextPageToken,
          ),
        );
      },
    );
  }
}
