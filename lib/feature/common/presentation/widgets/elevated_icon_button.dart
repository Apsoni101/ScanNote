import 'package:flutter/material.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';

class ElevatedIconButton extends StatelessWidget {
  const ElevatedIconButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    super.key,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(final BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: context.appColors.white),
      label: Text(
        label,
        style: AppTextStyles.airbnbCerealW500S14Lh20Ls0.copyWith(
          color: context.appColors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: context.appColors.primaryBlue,
        foregroundColor: context.appColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
    );
  }
}
