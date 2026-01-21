import 'package:flutter/material.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';

class QrScanInstructionText extends StatelessWidget {
  const QrScanInstructionText({super.key});

  @override
  Widget build(final BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    final double horizontalPadding = screenSize.width * 0.064;
    final double verticalPadding = screenSize.height * 0.015;
    final double borderRadius = screenSize.width * 0.02;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      decoration: BoxDecoration(
        color: context.appColors.black.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Text(
        context.locale.pointCameraToScanQr,
        style: AppTextStyles.airbnbCerealW400S14Lh20Ls0.copyWith(
          color: context.appColors.white,
        ),
      ),
    );
  }
}
