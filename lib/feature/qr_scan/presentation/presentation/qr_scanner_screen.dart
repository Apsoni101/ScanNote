import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/di/app_injector.dart';
import 'package:qr_scanner_practice/core/extensions/color_extension.dart';
import 'package:qr_scanner_practice/core/extensions/localization_extension.dart';
import 'package:qr_scanner_practice/core/navigation/app_router.gr.dart';
import 'package:qr_scanner_practice/feature/qr_scan/presentation/bloc/qr_scanning_bloc/qr_scanning_bloc.dart';
import 'package:qr_scanner_practice/feature/qr_scan/presentation/widgets/scanner_overlay_painter.dart';
import 'package:qr_scanner_practice/feature/result_scan/presentation/presentation/result_screen.dart';

@RoutePage()
class ResultScanningScreen extends StatelessWidget {
  const ResultScanningScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return BlocProvider<ResultScanningBloc>(
      create: (_) => AppInjector.getIt<ResultScanningBloc>(),
      child: const _ResultScanningView(),
    );
  }
}

class _ResultScanningView extends StatefulWidget {
  const _ResultScanningView();

  @override
  State<_ResultScanningView> createState() => _ResultScanningViewState();
}

class _ResultScanningViewState extends State<_ResultScanningView> {
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
    context.read<ResultScanningBloc>().add(QrDetectedEvent(code));
    _controller.stop();
    context.router.push(
      ResultRoute(
        data: code,
        resultType: ResultType.qr,
      ),
    ).then((_) {
      if (mounted) {
        _controller.start();
        context.read<ResultScanningBloc>().add(const ResetNavigationEvent());
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.locale.noQrCodeFound),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } else {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.locale.noQrCodeFound),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(final BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);

    return BlocListener<ResultScanningBloc, ResultScanningState>(
      listener: (final BuildContext context, final ResultScanningState state) {
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
        appBar: _ScanningAppBar(controller: _controller),
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
            _ScannerOverlay(screenSize: screenSize),
            Positioned(
              bottom: screenSize.height * 0.175,
              left: 0,
              right: 0,
              child: Center(child: _InstructionText()),
            ),
            _BottomActionButtons(controller: _controller),
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

/// App bar for the QR scanning screen.
/// Contains close button and flash toggle button.
class _ScanningAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _ScanningAppBar({required this.controller});

  final MobileScannerController controller;

  @override
  Widget build(final BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(Icons.close, color: context.appColors.white),
        onPressed: () => context.router.maybePop(),
      ),
      actions: <Widget>[_FlashToggleButton(controller: controller)],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// Bottom action buttons for gallery and camera image capture.
/// Displays as a row of two FAB-style buttons with labels.
class _BottomActionButtons extends StatelessWidget {
  const _BottomActionButtons({required this.controller});

  final MobileScannerController controller;

  @override
  Widget build(final BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);

    return Positioned(
      bottom: screenSize.height * 0.02,
      left: 0,
      right: 0,
      child: BlocSelector<ResultScanningBloc, ResultScanningState, bool>(
        selector: (final ResultScanningState state) => state.isProcessingImage,
        builder: (final BuildContext context, final bool isProcessing) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: screenSize.width * 0.05,
            children: <Widget>[
              _ActionButton(
                icon: Icons.image,
                label: context.locale.gallery,
                onPressed: isProcessing
                    ? null
                    : () {
                        context.read<ResultScanningBloc>().add(
                          const ScanQrFromGalleryEvent(),
                        );
                      },
              ),
              _ActionButton(
                icon: Icons.camera_alt,
                label: context.locale.camera,
                onPressed: isProcessing
                    ? null
                    : () {
                        context.read<ResultScanningBloc>().add(
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

/// Individual action button with icon and label.
/// Disabled state applies opacity to the button.
class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(final BuildContext context) {
    return Column(
      spacing: 4,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        FloatingActionButton(
          mini: true,
          backgroundColor: onPressed != null
              ? context.appColors.white
              : context.appColors.white.withValues(alpha: 0.5),
          onPressed: onPressed,
          child: Icon(icon, color: context.appColors.black),
        ),
        Text(
          label,
          style: AppTextStyles.airbnbCerealW400S12Lh16.copyWith(
            color: context.appColors.white,
          ),
        ),
      ],
    );
  }
}

/// Flash toggle button for camera flash control.
/// Displays flash on/off icon based on current state.
class _FlashToggleButton extends StatelessWidget {
  const _FlashToggleButton({required this.controller});

  final MobileScannerController controller;

  @override
  Widget build(final BuildContext context) {
    return BlocSelector<ResultScanningBloc, ResultScanningState, bool>(
      selector: (final ResultScanningState state) => state.isFlashOn,
      builder: (final BuildContext context, final bool isFlashOn) {
        return IconButton(
          icon: Icon(
            isFlashOn ? Icons.flash_on : Icons.flash_off,
            color: context.appColors.white,
          ),
          onPressed: () {
            context.read<ResultScanningBloc>().add(const ToggleFlashEvent());
            controller.toggleTorch();
          },
        );
      },
    );
  }
}

/// Scanner overlay with semi-transparent background and corner indicators.
/// Highlights the scanning area in the center of the screen.
class _ScannerOverlay extends StatelessWidget {
  const _ScannerOverlay({required this.screenSize});

  final Size screenSize;

  @override
  Widget build(final BuildContext context) {
    final double frameSize = screenSize.width * 0.65;

    return CustomPaint(
      size: screenSize,
      painter: ScannerOverlayPainter(
        frameSize: frameSize,
        overlayColor: context.appColors.black.withValues(alpha: 0.65),
        cornerColor: context.appColors.white,
        screenSize: screenSize,
      ),
    );
  }
}

/// Instruction text displayed above the bottom action buttons.
/// Guides user to point camera at QR code.
class _InstructionText extends StatelessWidget {
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
