import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_practice/core/di/app_injector.dart';
import 'package:qr_scanner_practice/core/enums/result_type.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';
import 'package:qr_scanner_practice/core/navigation/app_router.gr.dart';
import 'package:qr_scanner_practice/feature/qr_scan/presentation/bloc/qr_scanning_bloc/qr_scanning_bloc.dart';
import 'package:qr_scanner_practice/feature/qr_scan/presentation/widgets/qr_scan_instruction_text.dart';
import 'package:qr_scanner_practice/feature/qr_scan/presentation/widgets/qr_scan_source_buttons.dart';
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
        .push(ResultRoute(data: code, resultType: ResultType.qr))
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(context.locale.noQrCodeFound),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);

    return BlocListener<QrScanningBloc, QrScanningState>(
      listener: (final BuildContext context, final QrScanningState state) {
        if (state.error != null && state.imagePath == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error ?? ''),
              duration: const Duration(seconds: 2),
            ),
          );
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
            MobileScanner(
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
            QrScannerOverlay(screenSize: screenSize),
            Positioned(
              bottom: screenSize.height * 0.175,
              left: 0,
              right: 0,
              child: const Center(child: QrScanInstructionText()),
            ),
            QrScanSourceButtons(controller: _controller),
          ],
        ),
      ),
    );
  }

  String _getErrorMessage(
    final BuildContext context,
    final MobileScannerException error,
  ) {
    if (error.errorCode == MobileScannerErrorCode.permissionDenied) {
      return context.locale.cameraPermissionDenied;
    }
    if (error.errorCode == MobileScannerErrorCode.unsupported) {
      return context.locale.scanningNotSupported;
    }
    if (error.errorCode == MobileScannerErrorCode.controllerDisposed) {
      return context.locale.scannerControllerDisposed;
    }
    return context.locale.scannerError(error.errorCode.name);
  }
}
