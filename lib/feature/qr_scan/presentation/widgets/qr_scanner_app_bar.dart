import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';
import 'package:qr_scanner_practice/feature/qr_scan/presentation/widgets/qr_flash_toggle_button.dart';

class QrScannerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const QrScannerAppBar({required this.controller, super.key});

  final MobileScannerController controller;

  @override
  Widget build(final BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: context.appColors.textInversePrimary,
        ),
        style: IconButton.styleFrom(
          backgroundColor: context.appColors.cameraOverlay,
          shape: RoundedRectangleBorder(borderRadius: .circular(10)),
        ),
        onPressed: () => context.router.maybePop(),
      ),
      actions: <Widget>[QrFlashToggleButton(controller: controller)],
    );
  }

  @override
  Size get preferredSize => const .fromHeight(kToolbarHeight);
}
