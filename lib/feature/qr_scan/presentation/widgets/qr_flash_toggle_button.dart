import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';
import 'package:qr_scanner_practice/feature/qr_scan/presentation/bloc/qr_scanning_bloc/qr_scanning_bloc.dart';

class QrFlashToggleButton extends StatelessWidget {
  const QrFlashToggleButton({required this.controller, super.key});

  final MobileScannerController controller;

  @override
  Widget build(final BuildContext context) {
    return BlocSelector<QrScanningBloc, QrScanningState, bool>(
      selector: (final QrScanningState state) => state.isFlashOn,
      builder: (final BuildContext context, final bool isFlashOn) {
        return IconButton(
          icon: Icon(
            isFlashOn ? Icons.flash_on : Icons.flash_off,
            color: context.appColors.white,
          ),
          onPressed: () {
            context.read<QrScanningBloc>().add(const ToggleFlashEvent());
            controller.toggleTorch();
          },
        );
      },
    );
  }
}
