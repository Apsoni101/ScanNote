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
    return Column(
      spacing: 4,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        FloatingActionButton(
          mini: true,
          backgroundColor: onPressed != null
              ? context.appColors.textInversePrimary
              : context.appColors.textInversePrimary.withValues(alpha: 0.5),
          onPressed: onPressed,
          child: Icon(icon, color: context.appColors.textPrimary),
        ),
        Text(
          label,
          style: AppTextStyles.airbnbCerealW400S12Lh16.copyWith(
            color: context.appColors.textInversePrimary,
          ),
        ),
      ],
    );
  }
}
