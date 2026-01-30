import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';

class ElevatedSvgIconButton extends StatelessWidget {
  const ElevatedSvgIconButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.backgroundColor,
    this.iconSize = 24,
    this.isLoading = false,
    super.key,
  });

  final String icon;
  final double iconSize;
  final String label;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(final BuildContext context) {
    return ElevatedButton.icon(
      onPressed: isLoading ? null : onPressed,
      icon: isLoading
          ? SizedBox(
              width: iconSize,
              height: iconSize,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: context.appColors.surfaceL1,
              ),
            )
          : SvgPicture.asset(icon, width: iconSize, height: iconSize),
      label: Text(
        isLoading ? context.locale.signingIn : label,
        style: AppTextStyles.airbnbCerealW500S16Lh24Ls0.copyWith(
          color: context.appColors.textInversePrimary,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        disabledBackgroundColor: backgroundColor.withValues(alpha: 0.8),
        shape: RoundedRectangleBorder(borderRadius: .circular(12)),
        padding: const .symmetric(horizontal: 32, vertical: 16),
      ),
    );
  }
}
