import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/result_scan_entity.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/sheet_entity.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/presentation/bloc/sheet_selection_bloc.dart';

class SaveToSheetButton extends StatelessWidget {
  const SaveToSheetButton({
    required this.scannedData,
    required this.userComment,
    super.key,
  });

  final String scannedData;
  final String userComment;

  @override
  Widget build(final BuildContext context) {
    return BlocSelector<
      SheetSelectionBloc,
      SheetSelectionState,
      ({bool canSave, bool isSaving, String? sheetId, String sheetTitle})
    >(
      selector: (final SheetSelectionState state) {
        final bool isBusy =
            state.isSavingScan ||
            state.isCreatingSheet ||
            state.isLoadingSheets;

        final String sheetTitle =
            state.sheets
                .where(
                  (final SheetEntity sheet) =>
                      sheet.id == state.selectedSheetId,
                )
                .map((final SheetEntity sheet) => sheet.title)
                .firstOrNull ??
            '';

        return (
          canSave:
              !isBusy &&
              state.selectedSheetId != null &&
              state.sheetsLoadError == null,
          isSaving: state.isSavingScan,
          sheetId: state.selectedSheetId,
          sheetTitle: sheetTitle,
        );
      },
      builder:
          (
            final BuildContext context,
            final ({
              bool canSave,
              bool isSaving,
              String? sheetId,
              String sheetTitle,
            })
            buttonState,
          ) {
            return Container(
              padding: const .all(16),
              decoration: BoxDecoration(
                color: context.appColors.surfaceL1,
                border: .symmetric(
                  horizontal: BorderSide(color: context.appColors.separator),
                ),
              ),
              child: ElevatedButton(
                onPressed: buttonState.canSave
                    ? () {
                        final ScanResultEntity scanResult = ScanResultEntity(
                          data: scannedData,
                          comment: userComment,
                          timestamp: .now(),
                        );

                        context.read<SheetSelectionBloc>().add(
                          OnConfirmationSaveScan(
                            scanResult,
                            buttonState.sheetId!,
                            buttonState.sheetTitle,
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.appColors.primaryDefault,
                  shape: RoundedRectangleBorder(borderRadius: .circular(16)),
                  padding: const .all(16),
                ),
                child: buttonState.isSaving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(
                        context.locale.saveToSheet,
                        style: AppTextStyles.airbnbCerealW500S14Lh20Ls0
                            .copyWith(
                              color: context.appColors.textInversePrimary,
                            ),
                      ),
              ),
            );
          },
    );
  }
}
