import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';

class OutlineSvgIconButton extends StatelessWidget {
  const OutlineSvgIconButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.outlineColor,
    this.iconSize = 24,
    this.isLoading = false,
    this.isEnabled = true,
    this.iconColor,
    super.key,
  });

  final String icon;
  final double iconSize;
  final String label;
  final Color outlineColor;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isEnabled;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final bool isButtonDisabled = !isEnabled || isLoading;

    return OutlinedButton.icon(
      onPressed: isButtonDisabled ? null : onPressed,
      icon: isLoading
          ? SizedBox(
              width: iconSize,
              height: iconSize,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: context.appColors.surfaceL1,
              ),
            )
          : SvgPicture.asset(
              icon,
              width: iconSize,
              height: iconSize,
              colorFilter: ColorFilter.mode(
                isButtonDisabled
                    ? context.appColors.textDisabled
                    : (iconColor ?? context.appColors.primaryDefault),
                BlendMode.srcIn,
              ),
            ),
      label: Text(
        isLoading ? context.locale.loading : label,
        style: AppTextStyles.airbnbCerealW500S16Lh24Ls0.copyWith(
          color: isButtonDisabled
              ? context.appColors.textDisabled
              : context.appColors.primaryDefault,
        ),
      ),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: .circular(12)),
        side: BorderSide(
          color: isButtonDisabled
              ? context.appColors.primaryDisabled
              : outlineColor,
          width: 2,
        ),
        padding: const .symmetric(horizontal: 32, vertical: 16),
      ),
    );
  }
}
