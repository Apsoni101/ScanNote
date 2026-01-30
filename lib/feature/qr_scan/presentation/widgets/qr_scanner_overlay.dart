import 'package:flutter/material.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';

class QrScannerOverlay extends StatefulWidget {
  const QrScannerOverlay({super.key});

  @override
  State<QrScannerOverlay> createState() => _QrScannerOverlayState();
}

class _QrScannerOverlayState extends State<QrScannerOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final double frameSize = MediaQuery.widthOf(context) * 0.65;

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, final __) {
        return CustomPaint(
          size: Size(frameSize, frameSize),
          painter: _ScannerOverlayPainter(
            frameSize: frameSize,
            color: context.appColors.primaryDefault,
            scanProgress: _controller.value,
          ),
        );
      },
    );
  }
}

class _ScannerOverlayPainter extends CustomPainter {
  _ScannerOverlayPainter({
    required this.frameSize,
    required this.color,
    required this.scanProgress,
  });

  final double frameSize;
  final Color color;
  final double scanProgress;

  final double cornerRadius = 8;
  final double edgeLength = 48;

  @override
  void paint(final Canvas canvas, final Size size) {
    final Offset center = size.center(Offset.zero);

    final Rect frameRect = Rect.fromCenter(
      center: center,
      width: frameSize,
      height: frameSize,
    );

    _drawCorners(canvas, frameRect);

    ///this is the moving scanner line
    _drawScannerLine(canvas, frameRect);
  }

  void _drawScannerLine(final Canvas canvas, final Rect rect) {
    final double y = rect.top + rect.height * scanProgress;

    final Rect lineRect = .fromLTWH(rect.left, y, rect.width, 2);

    final Paint paint = Paint()
      ..shader = LinearGradient(
        colors: <Color>[
          Colors.transparent,
          color.withValues(alpha: 0.9),
          Colors.transparent,
        ],
      ).createShader(lineRect);

    canvas.drawRect(lineRect, paint);
  }

  void _drawCorners(final Canvas canvas, final Rect rect) {
    final Paint paint = Paint()
      ..color = color
      /// this determines the width of my fram of qr scanner
      ..strokeWidth = frameSize * 0.010
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // ─── Top Left
    canvas
      ..drawArc(
        .fromLTWH(rect.left, rect.top, cornerRadius * 2, cornerRadius * 2),
        3.14,
        1.57,
        false,
        paint,
      )
      ..drawLine(
        Offset(rect.left + cornerRadius, rect.top),
        Offset(rect.left + cornerRadius + edgeLength, rect.top),
        paint,
      )
      ..drawLine(
        Offset(rect.left, rect.top + cornerRadius),
        Offset(rect.left, rect.top + cornerRadius + edgeLength),
        paint,
      )
      // ─── Top Right
      ..drawArc(
        .fromLTWH(
          rect.right - cornerRadius * 2,
          rect.top,
          cornerRadius * 2,
          cornerRadius * 2,
        ),
        4.71,
        1.57,
        false,
        paint,
      )
      ..drawLine(
        Offset(rect.right - cornerRadius, rect.top),
        Offset(rect.right - cornerRadius - edgeLength, rect.top),
        paint,
      )
      ..drawLine(
        Offset(rect.right, rect.top + cornerRadius),
        Offset(rect.right, rect.top + cornerRadius + edgeLength),
        paint,
      )
      // ─── Bottom Right
      ..drawArc(
        .fromLTWH(
          rect.right - cornerRadius * 2,
          rect.bottom - cornerRadius * 2,
          cornerRadius * 2,
          cornerRadius * 2,
        ),
        0,
        1.57,
        false,
        paint,
      )
      ..drawLine(
        Offset(rect.right - cornerRadius, rect.bottom),
        Offset(rect.right - cornerRadius - edgeLength, rect.bottom),
        paint,
      )
      ..drawLine(
        Offset(rect.right, rect.bottom - cornerRadius),
        Offset(rect.right, rect.bottom - cornerRadius - edgeLength),
        paint,
      )
      // ─── Bottom Left
      ..drawArc(
        .fromLTWH(
          rect.left,
          rect.bottom - cornerRadius * 2,
          cornerRadius * 2,
          cornerRadius * 2,
        ),
        1.57,
        1.57,
        false,
        paint,
      )
      ..drawLine(
        Offset(rect.left + cornerRadius, rect.bottom),
        Offset(rect.left + cornerRadius + edgeLength, rect.bottom),
        paint,
      )
      ..drawLine(
        Offset(rect.left, rect.bottom - cornerRadius),
        Offset(rect.left, rect.bottom - cornerRadius - edgeLength),
        paint,
      );
  }

  @override
  bool shouldRepaint(covariant final _ScannerOverlayPainter oldDelegate) {
    return oldDelegate.scanProgress != scanProgress;
  }
}
