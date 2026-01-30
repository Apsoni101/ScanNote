import 'package:flutter/material.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';

class SettingsAboutTextButtonTile extends StatelessWidget {
  const SettingsAboutTextButtonTile({
    required this.title,
    required this.onPressed,
    super.key,
  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(final BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        alignment: AlignmentDirectional.centerStart,
        padding: const .all(16),
      ),
      child: Text(
        title,
        style: AppTextStyles.airbnbCerealW500S16Lh24Ls0.copyWith(
          color: context.appColors.textPrimary,
        ),
      ),
    );
  }
}
