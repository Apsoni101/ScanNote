import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';
import 'package:qr_scanner_practice/feature/common/presentation/widgets/elevated_icon_button.dart';
import 'package:qr_scanner_practice/feature/ocr/presentation/bloc/ocr_bloc.dart';

class OcrContentView extends StatelessWidget {
  const OcrContentView({super.key});

  @override
  Widget build(final BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      shrinkWrap: true,
      children: <Widget>[
        Icon(
          Icons.document_scanner_outlined,
          size: 100,
          color: context.appColors.slate,
        ),
        const SizedBox(height: 24),
        Text(
          context.locale.selectImagePrompt,
          style: AppTextStyles.airbnbCerealW500S18Lh24Ls0.copyWith(
            color: context.appColors.darkGrey,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 48),
        const OcrActionButtons(),
      ],
    );
  }
}

class OcrActionButtons extends StatelessWidget {
  const OcrActionButtons({super.key});

  @override
  Widget build(final BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ElevatedIconButton(
            icon: Icons.camera_alt,
            label: context.locale.cameraButtonLabel,
            onPressed: () {
              context.read<OcrBloc>().add(const PickImageFromCameraEvent());
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedIconButton(
            icon: Icons.photo_library,
            label: context.locale.galleryButtonLabel,
            onPressed: () {
              context.read<OcrBloc>().add(const PickImageFromGalleryEvent());
            },
          ),
        ),
      ],
    );
  }
}
