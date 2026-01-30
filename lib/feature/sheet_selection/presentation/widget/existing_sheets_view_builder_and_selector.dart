import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/constants/asset_constants.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';
import 'package:qr_scanner_practice/core/extensions/string_extensions.dart';
import 'package:qr_scanner_practice/feature/common/presentation/widgets/common_loading_view.dart';
import 'package:qr_scanner_practice/feature/common/presentation/widgets/decorated_svg_asset_icon_container.dart';
import 'package:qr_scanner_practice/feature/common/presentation/widgets/elevated_icon_button.dart';
import 'package:qr_scanner_practice/feature/common/presentation/widgets/error_or_empty_message_container.dart';
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
      })
    >(
      selector: (final SheetSelectionState state) => (
        isFetchingSheets: state.isLoadingSheets,
        isLoadingMore: state.isLoadingMoreSheets,
        hasMore: state.hasMoreSheets,
        loadError: state.sheetsLoadError,
        availableSheets: state.sheets,
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
                      _SheetListView(
                        availableSheets: sheetData.availableSheets,
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

class _SheetListView extends StatelessWidget {
  const _SheetListView({required this.availableSheets});

  final List<SheetEntity> availableSheets;

  @override
  Widget build(final BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: availableSheets.length,
      separatorBuilder: (final _, final __) => const SizedBox(height: 8),
      itemBuilder: (final _, final int sheetIndex) {
        final SheetEntity currentSheet = availableSheets[sheetIndex];
        return _SelectableSheetItem(sheetData: currentSheet);
      },
    );
  }
}

class _SelectableSheetItem extends StatelessWidget {
  const _SelectableSheetItem({required this.sheetData});

  final SheetEntity sheetData;

  @override
  Widget build(final BuildContext context) {
    return BlocSelector<SheetSelectionBloc, SheetSelectionState, String?>(
      selector: (final SheetSelectionState state) => state.selectedSheetId,
      builder: (final BuildContext context, final String? selectedSheetId) {
        final bool isSelected = selectedSheetId == sheetData.id;

        return Card(
          color: isSelected
              ? context.appColors.primaryDefault
              : context.appColors.surfaceL1,
          shape: RoundedRectangleBorder(borderRadius: .circular(16)),

          child: ListTile(
            shape: RoundedRectangleBorder(borderRadius: .circular(16)),
            onTap: () {
              context.read<SheetSelectionBloc>().add(
                OnConfirmationSheetSelected(sheetData.id),
              );
            },
            leading: DecoratedSvgAssetIconContainer(
              assetPath: AppAssets.sheetIc,
              backgroundColor: isSelected
                  ? context.appColors.surfaceL1.withValues(alpha: 0.16)
                  : context.appColors.primaryDefault.withValues(alpha: 0.12),
              iconColor: isSelected
                  ? context.appColors.surfaceL1
                  : context.appColors.primaryDefault,
            ),

            title: Text(
              sheetData.title,
              maxLines: 1,
              overflow: .ellipsis,
              style: AppTextStyles.airbnbCerealW600S14Lh20Ls0.copyWith(
                color: isSelected
                    ? context.appColors.textInversePrimary
                    : context.appColors.textPrimary,
              ),
            ),
            subtitle: sheetData.modifiedTime == null
                ? null
                : Text(
                    context.locale.modified(
                      sheetData.modifiedTime.toFriendlyDate(),
                    ),
                    style: AppTextStyles.airbnbCerealW400S12Lh16.copyWith(
                      color: isSelected
                          ? Colors.white.withValues(alpha: 0.75)
                          : context.appColors.textSecondary,
                      fontSize: 11,
                    ),
                  ),
            trailing: AnimatedOpacity(
              opacity: isSelected ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              child: Icon(
                Icons.check_rounded,
                color: context.appColors.surfaceL1,
              ),
            ),
          ),
        );
      },
    );
  }
}
