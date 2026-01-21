import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';
import 'package:qr_scanner_practice/core/navigation/app_router.gr.dart';
import 'package:qr_scanner_practice/feature/common/presentation/widgets/elevated_icon_button.dart';
import 'package:qr_scanner_practice/feature/common/presentation/widgets/outlined_icon_button.dart';

class ActionButtonsSection extends StatelessWidget {
  const ActionButtonsSection({super.key});

  @override
  Widget build(final BuildContext context) {
    return Column(
      spacing: 16,
      children: <Widget>[
        ElevatedIconButton(
          icon: Icons.qr_code_scanner,
          label: context.locale.scanQrCode,
          onPressed: () => context.router.push(const QrScanningRoute()),
        ),
        OutlinedIconButton(
          icon: Icons.text_fields,
          label: context.locale.extractText,
          onPressed: () => context.router.push(const OcrRoute()),
        ),
        OutlinedIconButton(
          icon: Icons.history,
          label: context.locale.viewHistory,
          onPressed: () => context.router.push(const ViewScansHistoryRoute()),
        ),
      ],
    );
  }
}
