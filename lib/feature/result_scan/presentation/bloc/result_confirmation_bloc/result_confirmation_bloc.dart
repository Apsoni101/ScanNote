import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:qr_scanner_practice/core/services/network/failure.dart';
import 'package:qr_scanner_practice/feature/result_scan/domain/entity/result_scan_entity.dart';
import 'package:qr_scanner_practice/feature/result_scan/domain/entity/sheet_entity.dart';
import 'package:qr_scanner_practice/feature/result_scan/domain/usecase/result_scan_local_use_case.dart';
import 'package:qr_scanner_practice/feature/result_scan/domain/usecase/result_scan_remote_use_case.dart';

part 'result_confirmation_event.dart';
part 'result_confirmation_state.dart';

class ResultConfirmationBloc
    extends Bloc<ResultConfirmationEvent, ResultConfirmationState> {
  ResultConfirmationBloc({
    required this.remoteUseCase,
    required this.localUseCase,
  }) : super(const ResultConfirmationInitial()) {
    on<OnConfirmationLoadSheets>(_onLoadSheets);
    on<OnConfirmationSheetSelected>(_onSheetSelected);
    on<OnConfirmationCreateSheet>(_onCreateSheet);
    on<OnConfirmationSheetNameChanged>(_onSheetNameChanged);
    on<OnConfirmationModeToggled>(_onModeToggled);
    on<OnConfirmationSaveScan>(_onSaveScan);
  }

  final ResultScanRemoteUseCase remoteUseCase;
  final ResultScanLocalUseCase localUseCase;

  Future<void> _onLoadSheets(
      final OnConfirmationLoadSheets event,
      final Emitter<ResultConfirmationState> emit,
      ) async {
    emit(state.copyWith(isLoadingSheets: true));

    final Either<Failure, List<SheetEntity>> remoteResult = await remoteUseCase
        .getOwnedSheets();

    await remoteResult.fold(
          (final Failure failure) async {
        final Either<Failure, List<SheetEntity>> localResult =
        await localUseCase.getLocalSheets();

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
          await localUseCase.cacheSheet(sheet);
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
      final Emitter<ResultConfirmationState> emit,
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
      final Emitter<ResultConfirmationState> emit,
      ) {
    emit(state.copyWith(newSheetName: event.sheetName));
  }

  void _onModeToggled(
      final OnConfirmationModeToggled event,
      final Emitter<ResultConfirmationState> emit,
      ) {
    emit(
      state.copyWith(isCreatingNewSheet: event.isCreating, newSheetName: ''),
    );
  }

  Future<void> _onCreateSheet(
      final OnConfirmationCreateSheet event,
      final Emitter<ResultConfirmationState> emit,
      ) async {
    final String trimmedName = state.newSheetName.trim();

    final bool isEmpty = trimmedName.isEmpty;

    if (isEmpty) {
      emit(state.copyWith(sheetCreationError: 'Sheet name cannot be empty'));
      return;
    }

    emit(state.copyWith(isCreatingSheet: true));

    final Either<Failure, String> createResult = await remoteUseCase
        .createSheet(trimmedName);

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

        await localUseCase.cacheSheet(sheet);

        final Either<Failure, List<SheetEntity>> loadResult = await localUseCase
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

        final Either<Failure, List<SheetEntity>> loadResult =
        await remoteUseCase.getOwnedSheets();

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
              await localUseCase.cacheSheet(sheet);
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
      final Emitter<ResultConfirmationState> emit,
      ) async {
    emit(state.copyWith(isSavingScan: true));

    final String sheetId = event.sheetId;
    final String sheetTitle = state.selectedSheetTitle ?? 'Unknown';

    final Either<Failure, Unit> remoteResult = await remoteUseCase.saveScan(
      event.scanEntity,
      sheetId,
    );

    await remoteResult.fold(
          (final Failure failure) async {
        final Either<Failure, Unit> localResult = await localUseCase
            .cacheResultScan(event.scanEntity, sheetId, sheetTitle);

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