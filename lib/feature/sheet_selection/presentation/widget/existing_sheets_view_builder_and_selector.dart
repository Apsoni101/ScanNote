import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';
import 'package:qr_scanner_practice/feature/common/presentation/widgets/common_loading_view.dart';
import 'package:qr_scanner_practice/feature/common/presentation/widgets/elevated_icon_button.dart';
import 'package:qr_scanner_practice/feature/common/presentation/widgets/error_or_empty_message_container.dart';
import 'package:qr_scanner_practice/feature/common/presentation/widgets/sheet_list_view.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/sheet_entity.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/presentation/bloc/sheet_selection_bloc.dart';

/// ============================================================================
/// EXISTING SHEET SELECTOR SECTION
/// ============================================================================
class ExistingSheetsViewBuilderAndSelector extends StatelessWidget {
  const ExistingSheetsViewBuilderAndSelector({super.key});

  @override
  Widget build(final BuildContext context) {
    return BlocSelector<
      SheetSelectionBloc,
      SheetSelectionState,
      ({
        bool isFetchingSheets,
        bool isLoadingMore,
        bool hasMore,
        String? loadError,
        List<SheetEntity> availableSheets,
        String? selectedSheetId,
      })
    >(
      selector: (final SheetSelectionState state) => (
        isFetchingSheets: state.isLoadingSheets,
        isLoadingMore: state.isLoadingMoreSheets,
        hasMore: state.hasMoreSheets,
        loadError: state.sheetsLoadError,
        availableSheets: state.sheets,
        selectedSheetId: state.selectedSheetId,
      ),
      builder:
          (
            final BuildContext context,
            final ({
              String? loadError,
              bool isLoadingMore,
              bool hasMore,
              bool isFetchingSheets,
              List<SheetEntity> availableSheets,
              String? selectedSheetId,
            })
            sheetData,
          ) {
            return Column(
              crossAxisAlignment: .start,
              children: <Widget>[
                if (sheetData.isFetchingSheets)
                  const CommonLoadingView()
                else if (sheetData.loadError != null)
                  ErrorOrEmptyMessageContainer(
                    message: sheetData.loadError ?? '',
                    backgroundColor: context.appColors.semanticsIconError
                        .withValues(alpha: 0.1),
                    textColor: context.appColors.semanticsIconError,
                  )
                else if (sheetData.availableSheets.isEmpty)
                  ErrorOrEmptyMessageContainer(
                    message: context.locale.noSheetsAvailable,
                    backgroundColor: context.appColors.borderInputDefault,
                    textColor: context.appColors.textSecondary,
                  )
                else
                  Column(
                    children: <Widget>[
                      SheetListView(
                        availableSheets: sheetData.availableSheets,
                        selectedSheetId: sheetData.selectedSheetId,
                        onSheetSelected: (final String sheetId) {
                          context.read<SheetSelectionBloc>().add(
                            OnConfirmationSheetSelected(sheetId),
                          );
                        },
                      ),

                      const SizedBox(height: 16),

                      if (sheetData.hasMore)
                        sheetData.isLoadingMore
                            ? const CommonLoadingView()
                            : ElevatedIconButton(
                                icon: Icons.expand_circle_down_outlined,
                                label: context.locale.loadMore,
                                backgroundColor:
                                    context.appColors.primaryDefault,
                                iconColor: context.appColors.surfaceL1,
                                labelColor:
                                    context.appColors.textInversePrimary,
                                onPressed: () {
                                  context.read<SheetSelectionBloc>().add(
                                    const OnConfirmationLoadMoreSheets(),
                                  );
                                },
                              ),
                    ],
                  ),
              ],
            );
          },
    );
  }
}
