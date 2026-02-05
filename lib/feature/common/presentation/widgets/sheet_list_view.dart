import 'package:flutter/material.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/constants/asset_constants.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';
import 'package:qr_scanner_practice/core/extensions/string_extensions.dart';
import 'package:qr_scanner_practice/feature/common/presentation/widgets/decorated_svg_asset_icon_container.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/sheet_entity.dart';

class SheetListView extends StatelessWidget {
  const SheetListView({
    required this.availableSheets,
    required this.selectedSheetId,
    required this.onSheetSelected,
    super.key,
  });

  final List<SheetEntity> availableSheets;
  final String? selectedSheetId;
  final void Function(String sheetId) onSheetSelected;

  @override
  Widget build(final BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: availableSheets.length,
      separatorBuilder: (final _, final __) => const SizedBox(height: 8),
      itemBuilder: (final _, final int sheetIndex) {
        final SheetEntity currentSheet = availableSheets[sheetIndex];
        return SelectableSheetItem(
          sheetData: currentSheet,
          isSelected: currentSheet.id == selectedSheetId,
          onSheetSelected: onSheetSelected,
        );
      },
    );
  }
}

class SelectableSheetItem extends StatelessWidget {
  const SelectableSheetItem({
    required this.sheetData,
    required this.isSelected,
    required this.onSheetSelected,
    super.key,
  });

  final SheetEntity sheetData;
  final bool isSelected;
  final void Function(String sheetId) onSheetSelected;

  @override
  Widget build(final BuildContext context) {
    return Card(
      color: isSelected
          ? context.appColors.primaryDefault
          : context.appColors.surfaceL1,
      shape: RoundedRectangleBorder(borderRadius: .circular(16)),

      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: .circular(16)),
        onTap: () => onSheetSelected(sheetData.id),
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
          child: Icon(Icons.check_rounded, color: context.appColors.surfaceL1),
        ),
      ),
    );
  }
}
