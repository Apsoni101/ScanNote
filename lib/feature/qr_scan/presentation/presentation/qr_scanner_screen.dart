import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_practice/core/di/app_injector.dart';
import 'package:qr_scanner_practice/core/enums/result_type.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';
import 'package:qr_scanner_practice/core/navigation/app_router.gr.dart';
import 'package:qr_scanner_practice/core/utils/toast_utils.dart';
import 'package:qr_scanner_practice/feature/qr_scan/presentation/bloc/qr_scanning_bloc/qr_scanning_bloc.dart';
import 'package:qr_scanner_practice/feature/qr_scan/presentation/widgets/qr_image_picker_button.dart';
import 'package:qr_scanner_practice/feature/qr_scan/presentation/widgets/qr_scan_instruction_text.dart';
import 'package:qr_scanner_practice/feature/qr_scan/presentation/widgets/qr_scanner_app_bar.dart';
import 'package:qr_scanner_practice/feature/qr_scan/presentation/widgets/qr_scanner_overlay.dart';

@RoutePage()
class QrScanningScreen extends StatelessWidget {
  const QrScanningScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return BlocProvider<QrScanningBloc>(
      create: (_) => AppInjector.getIt<QrScanningBloc>(),
      child: const QrScanningView(),
    );
  }
}

class QrScanningView extends StatefulWidget {
  const QrScanningView({super.key});

  @override
  State<QrScanningView> createState() => QrScanningViewState();
}

class QrScanningViewState extends State<QrScanningView> {
  late final MobileScannerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MobileScannerController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleQrDetected(final String code) {
    context.read<QrScanningBloc>().add(QrDetectedEvent(code));
    _controller.stop();
    context.router
        .push(ScanResultRoute(scanResult: code, resultType: .qr))
        .then((_) {
          if (mounted) {
            _controller.start();
            context.read<QrScanningBloc>().add(const ResetNavigationEvent());
          }
        });
  }

  Future<void> _analyzeImageForQr(final String imagePath) async {
    final BarcodeCapture? barcodeCapture = await _controller.analyzeImage(
      imagePath,
    );

    if (barcodeCapture != null &&
        barcodeCapture.barcodes.isNotEmpty &&
        mounted) {
      final String? qrValue = barcodeCapture.barcodes.first.rawValue;
      if (qrValue != null && qrValue.isNotEmpty) {
        _handleQrDetected(qrValue);
      } else {
        _showNoQrFoundMessage();
      }
    } else {
      if (!mounted) {
        return;
      }
      _showNoQrFoundMessage();
    }
  }

  void _showNoQrFoundMessage() {
    ToastUtils.showToast(
      context,
      context.locale.noQrCodeFound,
      isSuccess: true,
    );
  }

  @override
  Widget build(final BuildContext context) {
    return BlocListener<QrScanningBloc, QrScanningState>(
      listener: (final BuildContext context, final QrScanningState state) {
        if (state.error != null && state.imagePath == null) {
          ToastUtils.showToast(context, state.error ?? '', isSuccess: false);
        }

        if (state.imagePath != null) {
          _analyzeImageForQr(state.imagePath!);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: QrScannerAppBar(controller: _controller),
        body: Stack(
          children: <Widget>[
            Positioned.fill(
              child: MobileScanner(
                controller: _controller,
                onDetect: (final BarcodeCapture capture) {
                  final String? code = capture.barcodes.firstOrNull?.rawValue;
                  if (code != null && code.isNotEmpty) {
                    _handleQrDetected(code);
                  }
                },
                errorBuilder:
                    (
                      final BuildContext context,
                      final MobileScannerException error,
                    ) {
                      return Center(
                        child: Text(_getErrorMessage(context, error)),
                      );
                    },
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const .all(12),
                child: Column(
                  children: <Widget>[
                    const Spacer(),
                    const QrScannerOverlay(),
                    const SizedBox(height: 32),
                    const QrScanInstructionText(),
                    const Spacer(),
                    Row(
                      mainAxisSize: .min,
                      mainAxisAlignment: .spaceEvenly,
                      spacing: 16,
                      children: <Widget>[
                        QrImagePickerButton(
                          icon: Icons.file_upload_outlined,
                          label: context.locale.uploadImage,
                          onPressed: () {
                            context.read<QrScanningBloc>().add(
                              const ScanQrFromGalleryEvent(),
                            );
                          },
                        ),
                        QrImagePickerButton(
                          icon: Icons.camera,
                          label: context.locale.captureImage,
                          onPressed: () {
                            context.read<QrScanningBloc>().add(
                              const ScanQrFromCameraEvent(),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getErrorMessage(
    final BuildContext context,
    final MobileScannerException error,
  ) {
    if (error.errorCode == .permissionDenied) {
      return context.locale.cameraPermissionDenied;
    }
    if (error.errorCode == .unsupported) {
      return context.locale.scanningNotSupported;
    }
    if (error.errorCode == .controllerDisposed) {
      return context.locale.scannerControllerDisposed;
    }
    return context.locale.scannerError(error.errorCode.name);
  }
}
