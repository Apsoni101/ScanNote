import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';
import 'package:qr_scanner_practice/feature/qr_scan/presentation/bloc/qr_scanning_bloc/qr_scanning_bloc.dart';
import 'package:qr_scanner_practice/feature/qr_scan/presentation/widgets/qr_image_picker_button.dart';

class QrScanSourceButtons extends StatelessWidget {
  const QrScanSourceButtons({required this.controller, super.key});

  final MobileScannerController controller;

  @override
  Widget build(final BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);

    return Positioned(
      bottom: screenSize.height * 0.02,
      left: 0,
      right: 0,
      child: BlocSelector<QrScanningBloc, QrScanningState, bool>(
        selector: (final QrScanningState state) => state.isProcessingImage,
        builder: (final BuildContext context, final bool isProcessing) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: screenSize.width * 0.05,
            children: <Widget>[
              QrImagePickerButton(
                icon: Icons.image,
                label: context.locale.gallery,
                onPressed: isProcessing
                    ? null
                    : () {
                        context.read<QrScanningBloc>().add(
                          const ScanQrFromGalleryEvent(),
                        );
                      },
              ),
              QrImagePickerButton(
                icon: Icons.camera_alt,
                label: context.locale.camera,
                onPressed: isProcessing
                    ? null
                    : () {
                        context.read<QrScanningBloc>().add(
                          const ScanQrFromCameraEvent(),
                        );
                      },
              ),
            ],
          );
        },
      ),
    );
  }
}
