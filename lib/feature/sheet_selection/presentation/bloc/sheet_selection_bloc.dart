import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/paged_sheets_entity.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/result_scan_entity.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/sheet_entity.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/use_case/sheet_selection_use_case.dart';

part 'sheet_selection_event.dart';

part 'sheet_selection_state.dart';

class SheetSelectionBloc
    extends Bloc<SheetSelectionEvent, SheetSelectionState> {
  SheetSelectionBloc({required this.useCase})
    : super(const ResultSavingInitial()) {
    on<OnConfirmationLoadSheets>(_onLoadSheets);
    on<OnConfirmationLoadMoreSheets>(_onLoadMoreSheets);

    on<OnConfirmationSheetSelected>(_onSheetSelected);
    on<OnConfirmationCreateSheet>(_onCreateSheet);
    on<OnConfirmationSheetNameChanged>(_onSheetNameChanged);
    on<OnConfirmationModeToggled>(_onModeToggled);
    on<OnConfirmationSaveScan>(_onSaveScan);
  }

  final SheetSelectionUseCase useCase;

  Future<void> _onLoadSheets(
    final OnConfirmationLoadSheets event,
    final Emitter<SheetSelectionState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoadingSheets: true,
        sheets: <SheetEntity>[],
        hasMoreSheets: true,
      ),
    );

    final Either<Failure, PagedSheetsEntity> result = await useCase
        .getOwnedSheets(pageSize: 5);

    await result.fold(
      (final Failure failure) async {
        final Either<Failure, List<SheetEntity>> local = await useCase
            .getLocalSheets();
        local.fold(
          (final Failure e) => emit(
            state.copyWith(
              isLoadingSheets: false,
              sheetsLoadError: failure.message,
            ),
          ),
          (final List<SheetEntity> sheets) => emit(
            state.copyWith(
              isLoadingSheets: false,
              sheets: sheets,
              isCachedData: true,
              hasMoreSheets: false,
            ),
          ),
        );
      },
      (final PagedSheetsEntity paged) async {
        await useCase.clearLocalSheets();

        for (final SheetEntity sheet in paged.sheets) {
          await useCase.saveSheetLocally(sheet);
        }

        emit(
          state.copyWith(
            isLoadingSheets: false,
            sheets: paged.sheets,
            nextPageToken: paged.nextPageToken,
            hasMoreSheets: paged.nextPageToken != null,
            isCachedData: false,
          ),
        );
      },
    );
  }

  Future<void> _onLoadMoreSheets(
    final OnConfirmationLoadMoreSheets event,
    final Emitter<SheetSelectionState> emit,
  ) async {
    if (state.isLoadingMoreSheets || !state.hasMoreSheets) {
      return;
    }

    emit(state.copyWith(isLoadingMoreSheets: true));

    final Either<Failure, PagedSheetsEntity> result = await useCase
        .getOwnedSheets(pageToken: state.nextPageToken, pageSize: 5);

    await result.fold(
      (final Failure failure) {
        emit(state.copyWith(isLoadingMoreSheets: false));
      },
      (final PagedSheetsEntity paged) async {
        for (final SheetEntity sheet in paged.sheets) {
          await useCase.saveSheetLocally(sheet);
        }

        emit(
          state.copyWith(
            isLoadingMoreSheets: false,
            sheets: <SheetEntity>[...state.sheets, ...paged.sheets],
            nextPageToken: paged.nextPageToken,
            hasMoreSheets: paged.nextPageToken != null,
          ),
        );
      },
    );
  }

  void _onSheetSelected(
    final OnConfirmationSheetSelected event,
    final Emitter<SheetSelectionState> emit,
  ) {
    final int selectedSheetIndex = state.sheets.indexWhere(
      (final SheetEntity s) => s.id == event.sheetId,
    );
    final SheetEntity? selectedSheet = selectedSheetIndex != -1
        ? state.sheets[selectedSheetIndex]
        : null;

    emit(
      state.copyWith(
        selectedSheetId: event.sheetId,
        selectedSheetTitle: selectedSheet?.title,
      ),
    );
  }

  void _onSheetNameChanged(
    final OnConfirmationSheetNameChanged event,
    final Emitter<SheetSelectionState> emit,
  ) {
    emit(state.copyWith(newSheetName: event.sheetName));
  }

  void _onModeToggled(
    final OnConfirmationModeToggled event,
    final Emitter<SheetSelectionState> emit,
  ) {
    emit(
      state.copyWith(isCreatingNewSheet: event.isCreating, newSheetName: ''),
    );
  }

  Future<void> _onCreateSheet(
    final OnConfirmationCreateSheet event,
    final Emitter<SheetSelectionState> emit,
  ) async {
    final String trimmedName = state.newSheetName.trim();

    final bool isEmpty = trimmedName.isEmpty;

    if (isEmpty) {
      emit(state.copyWith(sheetCreationError: 'Sheet name cannot be empty'));
      return;
    }

    emit(state.copyWith(isCreatingSheet: true));

    final Either<Failure, String> createResult = await useCase.createSheet(
      trimmedName,
    );

    await createResult.fold(
      (final Failure failure) async {
        emit(
          state.copyWith(
            isCreatingSheet: false,
            sheetCreationError: 'Sheet created locally. Will sync when online.',
          ),
        );

        final String tempId = 'local_${DateTime.now().millisecondsSinceEpoch}';

        final SheetEntity sheet = SheetEntity(
          id: tempId,
          title: trimmedName,
          createdTime: DateTime.now().toIso8601String(),
          modifiedTime: DateTime.now().toIso8601String(),
        );

        await useCase.saveSheetLocally(sheet);

        final Either<Failure, List<SheetEntity>> loadResult = await useCase
            .getLocalSheets();

        loadResult.fold(
          (final Failure localFailure) {
            emit(
              state.copyWith(
                sheetsLoadError: localFailure.message,
                isCreatingNewSheet: false,
                newSheetName: '',
              ),
            );
          },
          (final List<SheetEntity> sheets) {
            emit(
              state.copyWith(
                sheets: sheets,
                selectedSheetId: tempId,
                selectedSheetTitle: trimmedName,
                isCreatingNewSheet: false,
                newSheetName: '',
                isCachedData: true,
              ),
            );
          },
        );
      },
      (final String sheetId) async {
        emit(state.copyWith(isCreatingSheet: false));

        final Either<Failure, PagedSheetsEntity> loadResult = await useCase
            .getOwnedSheets(pageSize: 5);

        await loadResult.fold(
          (final Failure failure) {
            emit(
              state.copyWith(
                sheetsLoadError: failure.message,
                isCreatingNewSheet: false,
                newSheetName: '',
              ),
            );
          },
          (final PagedSheetsEntity pagedSheetsEntity) async {
            for (final SheetEntity sheet in pagedSheetsEntity.sheets) {
              await useCase.saveSheetLocally(sheet);
            }
            final List<SheetEntity> sheets = pagedSheetsEntity.sheets;

            final int newSheetIndex = sheets.indexWhere(
              (final SheetEntity s) => s.id == sheetId,
            );
            final SheetEntity? newSheet = newSheetIndex != -1
                ? sheets[newSheetIndex]
                : null;

            emit(
              state.copyWith(
                sheets: sheets,
                selectedSheetId: sheetId,
                selectedSheetTitle: newSheet?.title,
                isCreatingNewSheet: false,
                newSheetName: '',
                isCachedData: false,
                nextPageToken: state.nextPageToken,
                hasMoreSheets: state.hasMoreSheets,
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _onSaveScan(
    final OnConfirmationSaveScan event,
    final Emitter<SheetSelectionState> emit,
  ) async {
    emit(state.copyWith(isSavingScan: true));

    final String sheetId = event.sheetId;
    final String sheetTitle = state.selectedSheetTitle ?? 'Unknown';

    final Either<Failure, Unit> remoteResult = await useCase.saveScan(
      event.scanEntity,
      sheetId,
    );

    await remoteResult.fold(
      (final Failure failure) async {
        final Either<Failure, Unit> localResult = await useCase.cacheScanResult(
          event.scanEntity,
          sheetId,
          sheetTitle,
        );

        localResult.fold(
          (final Failure localFailure) {
            emit(
              state.copyWith(
                isSavingScan: false,
                scanSaveError: 'Failed to save: ${localFailure.message}',
              ),
            );
          },
          (_) {
            emit(
              state.copyWith(
                isSavingScan: false,
                isScanSaved: true,
                scanSaveError: failure.message,
              ),
            );
          },
        );
      },
      (_) async {
        emit(state.copyWith(isSavingScan: false, isScanSaved: true));
      },
    );
  }
}
