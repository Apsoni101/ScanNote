import 'package:flutter/material.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';

class ElevatedIconButton extends StatelessWidget {
  const ElevatedIconButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.iconColor,
    this.backgroundColor,
    this.labelColor,
    this.borderSide,
    super.key,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color? iconColor;
  final Color? labelColor;
  final Color? backgroundColor;
  final BorderSide? borderSide;

  @override
  Widget build(final BuildContext context) {
    final Color resolvedBgColor =
        backgroundColor ?? context.appColors.iconPrimary;

    final Color resolvedIconColor =
        iconColor ?? context.appColors.textInversePrimary;

    final Color resolvedLabelColor =
        labelColor ?? context.appColors.textInversePrimary;

    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: resolvedIconColor),
      label: Text(
        label,
        style: AppTextStyles.airbnbCerealW500S14Lh20Ls0.copyWith(
          color: resolvedLabelColor,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: resolvedBgColor,
        elevation: 0,
        padding: const .symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: .circular(12),
          side: borderSide ?? .none,
        ),
      ),
    );
  }
}
