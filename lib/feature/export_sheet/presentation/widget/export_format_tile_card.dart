import 'package:flutter/material.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';

class ExportFormatTileCard extends StatelessWidget {
  const ExportFormatTileCard({
    required this.icon,
    required this.iconBackgroundColor,
    required this.selectedTextColor,
    required this.isSelected,
    required this.onTap,
    required this.subtitle,
    required this.title,
    super.key,
  });

  final String icon;
  final Color iconBackgroundColor;
  final Color selectedTextColor;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.appColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: isSelected
            ? Border.all(color: context.appColors.primaryDefault, width: 2)
            : null,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const .symmetric(horizontal: 16, vertical: 12),
        leading: Container(
          padding: const .all(8),
          decoration: BoxDecoration(
            color: iconBackgroundColor,
            borderRadius: .circular(8),
          ),
          child: Text(icon, style: const TextStyle(fontSize: 24)),
        ),
        title: Text(
          title,
          style: AppTextStyles.airbnbCerealW600S14Lh20Ls0.copyWith(
            color: isSelected
                ? selectedTextColor
                : context.appColors.textPrimary,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: AppTextStyles.airbnbCerealW400S12Lh16Ls0,
        ),
        trailing: isSelected
            ? CircleAvatar(
                backgroundColor: context.appColors.primaryDefault,
                radius: 12,
                child: Icon(
                  Icons.check,
                  color: context.appColors.surfaceL1,
                  size: 20,
                ),
              )
            : null,
      ),
    );
  }
}
