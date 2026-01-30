import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner_practice/core/constants/asset_constants.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';
import 'package:qr_scanner_practice/feature/common/presentation/widgets/on_screen_option_item_card.dart';
import 'package:qr_scanner_practice/feature/ocr/presentation/bloc/ocr_bloc.dart';

class OcrScreenContentView extends StatelessWidget {
  const OcrScreenContentView({super.key});

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const .all(24),
      child: Column(
        mainAxisAlignment: .center,
        spacing: 12,
        children: <Widget>[
          OnScreenOptionItemCard(
            iconPath: AppAssets.cameraIc,
            title: context.locale.extractFromCamera,
            subtitle: context.locale.capturePhotoAndExtractTextInstantly,
            animationDuration: const Duration(milliseconds: 600),
            onPressed: () {
              context.read<OcrBloc>().add(const PickImageFromCameraEvent());
            },
          ),
          OnScreenOptionItemCard(
            iconPath: AppAssets.imageIc,
            title: context.locale.extractFromImage,
            subtitle: context.locale.uploadExistingImageToExtractText,
            animationDuration: const Duration(seconds: 1),
            onPressed: () {
              context.read<OcrBloc>().add(const PickImageFromGalleryEvent());
            },
          ),
        ],
      ),
    );
  }
}
