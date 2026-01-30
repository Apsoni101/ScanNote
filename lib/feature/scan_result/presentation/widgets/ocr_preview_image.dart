import 'package:flutter/material.dart';
import 'package:qr_scanner_practice/feature/common/presentation/widgets/rounded_corner_elevated_card.dart';

class OcrImagePreview extends StatelessWidget {
  const OcrImagePreview({required this.image, super.key});

  final ImageProvider image;

  @override
  Widget build(final BuildContext context) {
    return RoundedCornerElevatedCard(
      child: Padding(
        padding: const .all(16),
        child: AspectRatio(
          aspectRatio: 1,
          child: Image(image: image, fit: .cover, width: .infinity),
        ),
      ),
    );
  }
}
