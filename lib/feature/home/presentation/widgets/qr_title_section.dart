import 'package:flutter/material.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';

class QrTitleSection extends StatelessWidget {
  const QrTitleSection({super.key});

  @override
  Widget build(final BuildContext context) {
    return Column(
      spacing: 12,
      children: <Widget>[
        Text(
          context.locale.scanQrCode,
          style: AppTextStyles.airbnbCerealW700S24Lh32LsMinus1.copyWith(
            color: context.appColors.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          context.locale.pointCameraToScanQr,
          style: AppTextStyles.airbnbCerealW400S14Lh20Ls0.copyWith(
            color: context.appColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
