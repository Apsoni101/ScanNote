import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:qr_scanner_practice/core/services/network/failure.dart';
import 'package:qr_scanner_practice/feature/qr_scan/domain/entity/qr_scan_entity.dart';
import 'package:qr_scanner_practice/feature/qr_scan/domain/entity/sheet_entity.dart';
import 'package:qr_scanner_practice/feature/qr_scan/domain/usecase/qr_result_remote_use_case.dart';
import 'package:qr_scanner_practice/feature/qr_scan/domain/usecase/qr_scan_local_use_case.dart';

part 'qr_result_confirmation_event.dart';

part 'qr_result_confirmation_state.dart';

class QrResultConfirmationBloc
    extends Bloc<QrResultConfirmationEvent, QrResultConfirmationState> {
  QrResultConfirmationBloc({
    required this.remoteUseCase,
    required this.localUseCase,
  }) : super(const QrResultConfirmationInitial()) {
    dev.log('🎯 QrResultConfirmationBloc initialized');
    on<OnConfirmationLoadSheets>(_onLoadSheets);
    on<OnConfirmationSheetSelected>(_onSheetSelected);
    on<OnConfirmationCreateSheet>(_onCreateSheet);
    on<OnConfirmationSheetNameChanged>(_onSheetNameChanged);
    on<OnConfirmationModeToggled>(_onModeToggled);
    on<OnConfirmationSaveScan>(_onSaveScan);
  }

  final QrResultRemoteUseCase remoteUseCase;
  final QrScanLocalUseCase localUseCase;

  /// Load sheets: try remote first, fallback to local
  Future<void> _onLoadSheets(
      final OnConfirmationLoadSheets event,
      final Emitter<QrResultConfirmationState> emit,
      ) async {
    dev.log('📋 Loading sheets - Starting...');
    emit(state.copyWith(isLoadingSheets: true));

    // Try to fetch from remote
    dev.log('🌐 Attempting to fetch sheets from remote...');
    final Either<Failure, List<SheetEntity>> remoteResult = await remoteUseCase
        .getOwnedSheets();

    await remoteResult.fold(
          (final Failure failure) async {
        dev.log('❌ Remote fetch failed: ${failure.message}');
        dev.log('💾 Falling back to local cache...');

        // Remote failed, try local cache
        final Either<Failure, List<SheetEntity>> localResult =
        await localUseCase.getLocalSheets();

        localResult.fold(
              (final Failure localFailure) {
            dev.log('❌ Local cache also failed: ${localFailure.message}');
            dev.log('🚨 Both remote and local failed - No sheets available');

            emit(
              state.copyWith(
                isLoadingSheets: false,
                sheetsLoadError: 'Failed to load sheets: ${failure.message}',
              ),
            );
          },
              (final List<SheetEntity> sheets) {
            dev.log('✅ Local cache success - Found ${sheets.length} sheets');
            dev.log('📦 Sheets loaded from cache: ${sheets.map((s) => s.title).toList()}');

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
        dev.log('✅ Remote fetch success - Found ${sheets.length} sheets');
        dev.log('🌐 Sheets loaded from remote: ${sheets.map((s) => s.title).toList()}');

        // Remote succeeded, cache locally and emit
        dev.log('💾 Caching ${sheets.length} sheets locally...');
        for (final SheetEntity sheet in sheets) {
          await localUseCase.cacheSheet(sheet);
          dev.log('  ✓ Cached: ${sheet.title}');
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

        dev.log('🎉 Load sheets completed successfully');
      },
    );
  }

  void _onSheetSelected(
      final OnConfirmationSheetSelected event,
      final Emitter<QrResultConfirmationState> emit,
      ) {
    dev.log('🎯 Sheet selected - ID: ${event.sheetId}');

    // Find the selected sheet to get its title
    final int selectedSheetIndex = state.sheets.indexWhere(
          (final SheetEntity s) => s.id == event.sheetId,
    );
    final SheetEntity? selectedSheet = selectedSheetIndex != -1
        ? state.sheets[selectedSheetIndex]
        : null;

    if (selectedSheet != null) {
      dev.log('✅ Sheet found: ${selectedSheet.title}');
    } else {
      dev.log('⚠️ Sheet not found in current sheets list');
    }

    emit(
      state.copyWith(
        selectedSheetId: event.sheetId,
        selectedSheetTitle: selectedSheet?.title,
      ),
    );
  }

  void _onSheetNameChanged(
      final OnConfirmationSheetNameChanged event,
      final Emitter<QrResultConfirmationState> emit,
      ) {
    dev.log('📝 Sheet name changed: "${event.sheetName}"');
    emit(state.copyWith(newSheetName: event.sheetName));
  }

  void _onModeToggled(
      final OnConfirmationModeToggled event,
      final Emitter<QrResultConfirmationState> emit,
      ) {
    dev.log('🔄 Mode toggled - Creating new sheet: ${event.isCreating}');
    emit(
      state.copyWith(isCreatingNewSheet: event.isCreating, newSheetName: ''),
    );
  }

  /// Create sheet: try remote first, fallback to local-only
  Future<void> _onCreateSheet(
      final OnConfirmationCreateSheet event,
      final Emitter<QrResultConfirmationState> emit,
      ) async {
    final String trimmedName = state.newSheetName.trim();
    dev.log('📄 Creating sheet - Name: "$trimmedName"');

    final bool isEmpty = trimmedName.isEmpty;

    if (isEmpty) {
      dev.log('⚠️ Sheet creation failed - Empty name');
      emit(state.copyWith(sheetCreationError: 'Sheet name cannot be empty'));
      return;
    }

    emit(state.copyWith(isCreatingSheet: true));

    // Try to create on remote first
    dev.log('🌐 Attempting to create sheet on remote...');
    final Either<Failure, String> createResult = await remoteUseCase
        .createSheet(trimmedName);

    await createResult.fold(
          (final Failure failure) async {
        dev.log('❌ Remote sheet creation failed: ${failure.message}');
        dev.log('💾 Creating sheet locally instead...');

        // Remote creation failed - inform user but allow offline creation
        emit(
          state.copyWith(
            isCreatingSheet: false,
            sheetCreationError: 'Sheet created locally. Will sync when online.',
          ),
        );

        // Create locally with temporary ID
        final String tempId = 'local_${DateTime.now().millisecondsSinceEpoch}';
        dev.log('🆔 Generated temp ID: $tempId');

        final SheetEntity sheet = SheetEntity(
          id: tempId,
          title: trimmedName,
          createdTime: DateTime.now().toIso8601String(),
          modifiedTime: DateTime.now().toIso8601String(),
        );

        await localUseCase.cacheSheet(sheet);
        dev.log('✅ Sheet cached locally: ${sheet.title}');

        // Reload sheets
        dev.log('🔄 Reloading local sheets...');
        final Either<Failure, List<SheetEntity>> loadResult = await localUseCase
            .getLocalSheets();

        loadResult.fold(
              (final Failure localFailure) {
            dev.log('❌ Failed to reload local sheets: ${localFailure.message}');

            emit(
              state.copyWith(
                sheetsLoadError: localFailure.message,
                isCreatingNewSheet: false,
                newSheetName: '',
              ),
            );
          },
              (final List<SheetEntity> sheets) {
            dev.log('✅ Local sheets reloaded - Total: ${sheets.length}');
            dev.log('🎉 Sheet created locally successfully');

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
        dev.log('✅ Remote sheet creation success - ID: $sheetId');

        // Remote creation succeeded
        emit(state.copyWith(isCreatingSheet: false));

        // Reload sheets from remote
        dev.log('🔄 Reloading sheets from remote...');
        final Either<Failure, List<SheetEntity>> loadResult =
        await remoteUseCase.getOwnedSheets();

        await loadResult.fold(
              (final Failure failure) {
            dev.log('❌ Failed to reload remote sheets: ${failure.message}');

            emit(
              state.copyWith(
                sheetsLoadError: failure.message,
                isCreatingNewSheet: false,
                newSheetName: '',
              ),
            );
          },
              (final List<SheetEntity> sheets) async {
            dev.log('✅ Remote sheets reloaded - Total: ${sheets.length}');

            // Cache locally
            dev.log('💾 Caching updated sheets locally...');
            for (final SheetEntity sheet in sheets) {
              await localUseCase.cacheSheet(sheet);
              dev.log('  ✓ Cached: ${sheet.title}');
            }

            // Find the newly created sheet to get its title
            final int newSheetIndex = sheets.indexWhere(
                  (final SheetEntity s) => s.id == sheetId,
            );
            final SheetEntity? newSheet = newSheetIndex != -1
                ? sheets[newSheetIndex]
                : null;

            if (newSheet != null) {
              dev.log('🎯 New sheet found: ${newSheet.title}');
            } else {
              dev.log('⚠️ New sheet not found in reloaded list');
            }

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

            dev.log('🎉 Sheet created remotely successfully');
          },
        );
      },
    );
  }

  /// Save scan with both sheetId and sheetTitle for pending sync tracking
  Future<void> _onSaveScan(
      final OnConfirmationSaveScan event,
      final Emitter<QrResultConfirmationState> emit,
      ) async {
    dev.log('💾 Saving scan - Sheet ID: ${event.sheetId}');
    dev.log('📊 Scan data: ${event.scanEntity.qrData}');

    emit(state.copyWith(isSavingScan: true));

    final String sheetId = event.sheetId;
    final String sheetTitle = state.selectedSheetTitle ?? 'Unknown';
    dev.log('📋 Target sheet: $sheetTitle');

    // Try to save remotely
    dev.log('🌐 Attempting to save scan remotely...');
    final Either<Failure, Unit> remoteResult = await remoteUseCase.saveScan(
      event.scanEntity,
      sheetId,
    );

    await remoteResult.fold(
          (final Failure failure) async {
        dev.log('❌ Remote save failed: ${failure.message}');
        dev.log('💾 Saving scan locally instead...');

        final Either<Failure, Unit> localResult = await localUseCase
            .cacheQrScan(event.scanEntity, sheetId, sheetTitle);

        localResult.fold(
              (final Failure localFailure) {
            dev.log('❌ Local save also failed: ${localFailure.message}');
            dev.log('🚨 Both remote and local save failed');

            emit(
              state.copyWith(
                isSavingScan: false,
                scanSaveError: 'Failed to save: ${localFailure.message}',
              ),
            );
          },
              (_) {
            dev.log('✅ Scan saved locally successfully');
            dev.log('⏳ Will sync when connection is restored');

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
        dev.log('✅ Scan saved remotely successfully');
        dev.log('🎉 Save scan completed');

        emit(state.copyWith(isSavingScan: false, isScanSaved: true));
      },
    );
  }
}