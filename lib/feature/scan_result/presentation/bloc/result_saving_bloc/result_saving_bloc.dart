import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:qr_scanner_practice/feature/scan_result/domain/entity/result_scan_entity.dart';
import 'package:qr_scanner_practice/feature/scan_result/domain/entity/sheet_entity.dart';
import 'package:qr_scanner_practice/feature/scan_result/domain/usecase/scan_result_use_case.dart';

part 'result_saving_event.dart';
part 'result_saving_state.dart';

class ResultSavingBloc extends Bloc<ResultSavingEvent, ResultSavingState> {
  ResultSavingBloc({required this.useCase})
    : super(const ResultSavingInitial()) {
    on<OnConfirmationLoadSheets>(_onLoadSheets);
    on<OnConfirmationSheetSelected>(_onSheetSelected);
    on<OnConfirmationCreateSheet>(_onCreateSheet);
    on<OnConfirmationSheetNameChanged>(_onSheetNameChanged);
    on<OnConfirmationModeToggled>(_onModeToggled);
    on<OnConfirmationSaveScan>(_onSaveScan);
  }

  final ScanResultUseCase useCase;

  Future<void> _onLoadSheets(
    final OnConfirmationLoadSheets event,
    final Emitter<ResultSavingState> emit,
  ) async {
    emit(state.copyWith(isLoadingSheets: true));

    final Either<Failure, List<SheetEntity>> remoteResult = await useCase
        .getOwnedSheets();

    await remoteResult.fold(
      (final Failure failure) async {
        final Either<Failure, List<SheetEntity>> localResult = await useCase
            .getLocalSheets();

        localResult.fold(
          (final Failure localFailure) {
            emit(
              state.copyWith(
                isLoadingSheets: false,
                sheetsLoadError: 'Failed to load sheets: ${failure.message}',
              ),
            );
          },
          (final List<SheetEntity> sheets) {
            emit(
              state.copyWith(
                isLoadingSheets: false,
                sheets: sheets,
                selectedSheetId: sheets.isNotEmpty ? sheets.first.id : null,
                selectedSheetTitle: sheets.isNotEmpty
                    ? sheets.first.title
                    : null,
                isCachedData: true,
              ),
            );
          },
        );
      },
      (final List<SheetEntity> sheets) async {
        for (final SheetEntity sheet in sheets) {
          await useCase.cacheSheet(sheet);
        }

        emit(
          state.copyWith(
            isLoadingSheets: false,
            sheets: sheets,
            selectedSheetId: sheets.isNotEmpty ? sheets.first.id : null,
            selectedSheetTitle: sheets.isNotEmpty ? sheets.first.title : null,
            isCachedData: false,
          ),
        );
      },
    );
  }

  void _onSheetSelected(
    final OnConfirmationSheetSelected event,
    final Emitter<ResultSavingState> emit,
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
    final Emitter<ResultSavingState> emit,
  ) {
    emit(state.copyWith(newSheetName: event.sheetName));
  }

  void _onModeToggled(
    final OnConfirmationModeToggled event,
    final Emitter<ResultSavingState> emit,
  ) {
    emit(
      state.copyWith(isCreatingNewSheet: event.isCreating, newSheetName: ''),
    );
  }

  Future<void> _onCreateSheet(
    final OnConfirmationCreateSheet event,
    final Emitter<ResultSavingState> emit,
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

        await useCase.cacheSheet(sheet);

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

        final Either<Failure, List<SheetEntity>> loadResult = await useCase
            .getOwnedSheets();

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
          (final List<SheetEntity> sheets) async {
            for (final SheetEntity sheet in sheets) {
              await useCase.cacheSheet(sheet);
            }

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
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _onSaveScan(
    final OnConfirmationSaveScan event,
    final Emitter<ResultSavingState> emit,
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
                scanSaveError:
                    'Saved locally. Will sync when connection is restored.',
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
