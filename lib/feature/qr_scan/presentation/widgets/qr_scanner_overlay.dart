import 'package:flutter/material.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';

/// Scanner overlay with semi-transparent background and corner indicators.
/// Highlights the scanning area in the center of the screen.
class QrScannerOverlay extends StatelessWidget {
  const QrScannerOverlay({required this.screenSize, super.key});

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

class ScannerOverlayPainter extends CustomPainter {
  ScannerOverlayPainter({
    required this.frameSize,
    required this.overlayColor,
    required this.cornerColor,
    required this.screenSize,
  });

  final double frameSize;
  final Color overlayColor;
  final Color cornerColor;
  final Size screenSize;

  late final double _cornerLength = frameSize * 0.108;
  late final double _strokeWidth = frameSize * 0.015;
  late final double _radius = frameSize * 0.046;

  @override
  void paint(final Canvas canvas, final Size size) {
    final Offset center = size.center(Offset.zero);

    final Rect rect = Rect.fromCenter(
      center: center,
      width: frameSize,
      height: frameSize,
    );

    final RRect rRect = RRect.fromRectAndRadius(rect, Radius.circular(_radius));

    /// Dark overlay with transparent cut-out
    final Path overlayPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(rRect)
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(overlayPath, Paint()..color = overlayColor);

    /// Corner lines
    final Paint paint = Paint()
      ..color = cornerColor
      ..strokeWidth = _strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    void drawCorner(final Offset start, final Offset h, final Offset v) {
      canvas
        ..drawLine(start, start + h, paint)
        ..drawLine(start, start + v, paint);
    }

    final double left = rect.left;
    final double right = rect.right;
    final double top = rect.top;
    final double bottom = rect.bottom;

    drawCorner(
      Offset(left, top),
      Offset(_cornerLength, 0),
      Offset(0, _cornerLength),
    );
    drawCorner(
      Offset(right, top),
      Offset(-_cornerLength, 0),
      Offset(0, _cornerLength),
    );
    drawCorner(
      Offset(left, bottom),
      Offset(_cornerLength, 0),
      Offset(0, -_cornerLength),
    );
    drawCorner(
      Offset(right, bottom),
      Offset(-_cornerLength, 0),
      Offset(0, -_cornerLength),
    );
  }

  @override
  bool shouldRepaint(_) => false;
}
