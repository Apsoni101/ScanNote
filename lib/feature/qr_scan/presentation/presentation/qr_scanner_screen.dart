import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/extensions/color_extension.dart';
import 'package:qr_scanner_practice/core/extensions/localization_extension.dart';
import 'package:qr_scanner_practice/core/navigation/app_router.gr.dart';
import 'package:qr_scanner_practice/core/services/image_picker_service.dart';
import 'package:qr_scanner_practice/feature/qr_scan/presentation/widget/scanner_overlay_painter.dart';

@RoutePage()
class QrScanningScreen extends StatefulWidget {
  const QrScanningScreen({super.key});

  @override
  State<QrScanningScreen> createState() => _QrScanningScreenState();
}

class _QrScanningScreenState extends State<QrScanningScreen> {
  final MobileScannerController _controller = MobileScannerController();
  final ValueNotifier<bool> _isFlashOn = ValueNotifier<bool>(false);
  final ImagePickerService _imagePickerService = ImagePickerService();

  bool _hasNavigated = false;
  bool _isProcessingImage = false;

  @override
  void dispose() {
    _controller.dispose();
    _isFlashOn.dispose();
    super.dispose();
  }

  void _onQrDetected(final String code) {
    if (_hasNavigated) {
      return;
    }

    _hasNavigated = true;
    _controller.stop();

    context.router.push(QrResultRoute(qrData: code)).then((_) {
      if (mounted) {
        _hasNavigated = false;
        _controller.start();
      }
    });
  }

  Future<void> _scanQrFromGallery() async {
    if (_isProcessingImage) {
      return;
    }

    _isProcessingImage = true;
    final String? imagePath = await _imagePickerService.pickImageFromGallery();

    if (imagePath != null) {
      await _processImageForQr(imagePath);
    }
    _isProcessingImage = false;
  }

  Future<void> _scanQrFromCamera() async {
    if (_isProcessingImage) {
      return;
    }

    _isProcessingImage = true;
    final String? imagePath = await _imagePickerService.pickImageFromCamera();

    if (imagePath != null) {
      await _processImageForQr(imagePath);
    }
    _isProcessingImage = false;
  }

  Future<void> _processImageForQr(final String imagePath) async {
    try {
      final BarcodeCapture? barcodeCapture = await _controller.analyzeImage(
        imagePath,
      );

      if (barcodeCapture != null && barcodeCapture.barcodes.isNotEmpty) {
        final String? qrValue = barcodeCapture.barcodes.first.rawValue;
        if (qrValue != null && qrValue.isNotEmpty) {
          _onQrDetected(qrValue);
        }
      } else {
        _showMessage('No QR code found in image');
      }
    } catch (e) {
      _showMessage('Error processing image');
    }
  }

  void _showMessage(final String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(final BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: _ScanningAppBar(controller: _controller, isFlashOn: _isFlashOn),
      body: Stack(
        children: <Widget>[
          MobileScanner(
            controller: _controller,
            onDetect: (final BarcodeCapture capture) {
              final String? code = capture.barcodes.firstOrNull?.rawValue;
              if (code != null && code.isNotEmpty) {
                _onQrDetected(code);
              }
            },
          ),
          _ScannerOverlay(screenSize: screenSize),
          Positioned(
            bottom: screenSize.height * 0.175,
            left: 0,
            right: 0,
            child: Center(child: _InstructionText()),
          ),
          _BottomActionButtons(
            onGalleryTap: _scanQrFromGallery,
            onCameraTap: _scanQrFromCamera,
            isProcessing: _isProcessingImage,
          ),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                              SCANNING APP BAR                               */
/* -------------------------------------------------------------------------- */

class _ScanningAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _ScanningAppBar({required this.controller, required this.isFlashOn});

  final MobileScannerController controller;
  final ValueNotifier<bool> isFlashOn;

  @override
  Widget build(final BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(Icons.close, color: context.appColors.white),
        onPressed: () => context.router.maybePop(),
      ),
      actions: <Widget>[
        _FlashToggleButton(controller: controller, isFlashOn: isFlashOn),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/* -------------------------------------------------------------------------- */
/*                            BOTTOM ACTION BUTTONS                            */
/* -------------------------------------------------------------------------- */

class _BottomActionButtons extends StatelessWidget {
  const _BottomActionButtons({
    required this.onGalleryTap,
    required this.onCameraTap,
    required this.isProcessing,
  });

  final VoidCallback onGalleryTap;
  final VoidCallback onCameraTap;
  final bool isProcessing;

  @override
  Widget build(final BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);

    return Positioned(
      bottom: screenSize.height * 0.02,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _ActionButton(
            icon: Icons.image,
            label: 'Gallery',
            onPressed: isProcessing ? null : onGalleryTap,
          ),
          SizedBox(width: screenSize.width * 0.05),
          _ActionButton(
            icon: Icons.camera_alt,
            label: 'Camera',
            onPressed: isProcessing ? null : onCameraTap,
          ),
        ],
      ),
    );
  }
}

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
        const SizedBox(height: 4),
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

/* -------------------------------------------------------------------------- */
/*                                FLASH BUTTON                                */
/* -------------------------------------------------------------------------- */

class _FlashToggleButton extends StatelessWidget {
  const _FlashToggleButton({required this.controller, required this.isFlashOn});

  final MobileScannerController controller;
  final ValueNotifier<bool> isFlashOn;

  @override
  Widget build(final BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isFlashOn,
      builder: (_, final bool flashOn, final __) {
        return IconButton(
          icon: Icon(
            flashOn ? Icons.flash_on : Icons.flash_off,
            color: context.appColors.white,
          ),
          onPressed: () async {
            await controller.toggleTorch();
            isFlashOn.value = !flashOn;
          },
        );
      },
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                              SCANNER OVERLAY                                */
/* -------------------------------------------------------------------------- */

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

/* -------------------------------------------------------------------------- */
/*                              INSTRUCTION TEXT                               */
/* -------------------------------------------------------------------------- */

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
