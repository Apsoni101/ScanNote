import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:qr_scanner_practice/core/enums/export_format_enum.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:qr_scanner_practice/feature/export_sheet/domain/use_case/export_sheet_use_case.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/paged_sheets_entity.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/sheet_entity.dart';

part 'export_sheet_event.dart';

part 'export_sheet_state.dart';

class ExportSheetBloc extends Bloc<ExportSheetEvent, ExportSheetState> {
  ExportSheetBloc({required this.exportSheetUseCase})
    : super(const ExportSheetInitial()) {
    on<SelectExportFormatEvent>(_onSelectExportFormat);
    on<LoadSheetsEvent>(_onLoadSheets);
    on<SelectSheetEvent>(_onSelectSheet);
    on<LoadMoreSheetsEvent>(_onLoadMoreSheets);
    on<DownloadSheetEvent>(_onDownloadSheet);
    on<ClearDownloadStateEvent>(_onClearDownloadState);
  }

  final ExportSheetUseCase exportSheetUseCase;

  Future<void> _onSelectExportFormat(
    final SelectExportFormatEvent event,
    final Emitter<ExportSheetState> emit,
  ) async {
    final ExportSheetState currentState = state;

    if (currentState is ExportSheetLoaded) {
      emit(currentState.copyWith(selectedFormat: event.format));
    } else {
      emit(ExportSheetInitial(selectedFormat: event.format));
    }
  }

  Future<void> _onLoadSheets(
    final LoadSheetsEvent event,
    final Emitter<ExportSheetState> emit,
  ) async {
    final ExportFormat currentFormat = state is ExportSheetLoaded
        ? (state as ExportSheetLoaded).selectedFormat
        : state is ExportSheetInitial
        ? (state as ExportSheetInitial).selectedFormat
        : ExportFormat.pdf;

    emit(ExportSheetLoading(selectedFormat: currentFormat));

    final Either<Failure, PagedSheetsEntity> result = await exportSheetUseCase
        .getOwnedSheets(pageToken: event.pageToken, pageSize: 2);

    result.fold(
      (final Failure failure) => emit(
        ExportSheetError(
          message: failure.message,
          selectedFormat: currentFormat,
        ),
      ),
      (final PagedSheetsEntity pagedSheets) => emit(
        ExportSheetLoaded(
          pagedSheets: pagedSheets,
          selectedFormat: currentFormat,
        ),
      ),
    );
  }

  Future<void> _onSelectSheet(
    final SelectSheetEvent event,
    final Emitter<ExportSheetState> emit,
  ) async {
    final ExportSheetState currentState = state;

    if (currentState is ExportSheetLoaded) {
      emit(
        currentState.copyWith(
          selectedSheetId: event.sheetId,
          selectedSheetName: event.sheetName,
        ),
      );
    }
  }

  Future<void> _onLoadMoreSheets(
    final LoadMoreSheetsEvent event,
    final Emitter<ExportSheetState> emit,
  ) async {
    final ExportSheetState currentState = state;

    if (currentState is! ExportSheetLoaded) {
      return;
    }
    if (!currentState.pagedSheets.hasMore) {
      return;
    }

    emit(currentState.copyWith(isLoadingMore: true));

    final Either<Failure, PagedSheetsEntity> result = await exportSheetUseCase
        .getOwnedSheets(
          pageToken: currentState.pagedSheets.nextPageToken,
          pageSize: 2,
        );

    result.fold(
      (final Failure failure) =>
          emit(currentState.copyWith(isLoadingMore: false)),
      (final PagedSheetsEntity newPagedSheets) {
        final List<SheetEntity> mergedSheets = <SheetEntity>[
          ...currentState.pagedSheets.sheets,
          ...newPagedSheets.sheets,
        ];

        final PagedSheetsEntity updatedPagedSheets = newPagedSheets.copyWith(
          sheets: mergedSheets,
        );

        emit(
          currentState.copyWith(
            pagedSheets: updatedPagedSheets,
            isLoadingMore: false,
          ),
        );
      },
    );
  }

  Future<void> _onDownloadSheet(
    final DownloadSheetEvent event,
    final Emitter<ExportSheetState> emit,
  ) async {
    final ExportSheetState currentState = state;

    if (currentState is! ExportSheetLoaded) {
      return;
    }

    if (currentState.selectedSheetId == null) {
      emit(
        currentState.copyWith(
          downloadError: 'Please select a sheet to download',
        ),
      );
      return;
    }

    emit(currentState.copyWith(isDownloading: true, downloadError: null));

    final Either<Failure, String> result = await exportSheetUseCase
        .downloadSheetFile(
          fileId: currentState.selectedSheetId ?? '',
          format: currentState.selectedFormat,
          sheetName: currentState.selectedSheetName ?? '',
        );

    result.fold(
      (final Failure failure) => emit(
        currentState.copyWith(
          isDownloading: false,
          downloadError: failure.message,
        ),
      ),
      (final String downloadedFilePath) => emit(
        currentState.copyWith(
          isDownloading: false,
          downloadedFilePath: downloadedFilePath,
          downloadError: null,
        ),
      ),
    );
  }

  Future<void> _onClearDownloadState(
    final ClearDownloadStateEvent event,
    final Emitter<ExportSheetState> emit,
  ) async {
    final ExportSheetState currentState = state;

    if (currentState is ExportSheetLoaded) {
      emit(
        currentState.copyWith(downloadedFilePath: null, downloadError: null),
      );
    }
  }

  @override
  Future<void> close() {
    exportSheetUseCase.dispose();
    return super.close();
  }
}
