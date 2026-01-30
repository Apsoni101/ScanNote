import 'package:flutter/material.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';

class QrImagePickerButton extends StatelessWidget {
  const QrImagePickerButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    super.key,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(final BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 24,
        color: context.appColors.buttonSecondaryBackground,
      ),
      label: Text(
        label,
        style: AppTextStyles.airbnbCerealW500S14Lh20Ls0.copyWith(
          color: context.appColors.textInversePrimary,
        ),
      ),
      style: ElevatedButton.styleFrom(
        padding: const .symmetric(horizontal: 24),
        backgroundColor: context.appColors.cameraOverlay,
        shape: RoundedRectangleBorder(borderRadius: .circular(12)),
      ),
    );
  }
}
