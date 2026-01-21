import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:qr_scanner_practice/feature/scan_result/domain/entity/pending_sync_entity.dart';
import 'package:qr_scanner_practice/feature/view_scan_history/domain/usecase/view_scans_history_remote_use_case.dart';

part 'view_scans_history_screen_event.dart';

part 'view_scans_history_screen_state.dart';

class ViewScansHistoryScreenBloc
    extends Bloc<ViewScansHistoryScreenEvent, ViewScansHistoryScreenState> {
  ViewScansHistoryScreenBloc({required this.getScansHistoryUseCase})
    : super(const HistoryScreenInitial()) {
    on<OnHistoryLoadScans>(_onLoadScans);
    on<OnHistorySearchScans>(_onSearchScans);
  }

  final ViewScansHistoryRemoteUseCase getScansHistoryUseCase;

  Future<void> _onLoadScans(
    final OnHistoryLoadScans event,
    final Emitter<ViewScansHistoryScreenState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final Either<Failure, List<PendingSyncEntity>> result =
        await getScansHistoryUseCase.getAllScansFromAllSheets();

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
    final Emitter<ViewScansHistoryScreenState> emit,
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
}
