import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner_practice/core/di/app_injector.dart';
import 'package:qr_scanner_practice/core/enums/result_type.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';
import 'package:qr_scanner_practice/core/navigation/app_router.gr.dart';
import 'package:qr_scanner_practice/core/utils/toast_utils.dart';
import 'package:qr_scanner_practice/feature/common/presentation/widgets/common_app_bar.dart';
import 'package:qr_scanner_practice/feature/common/presentation/widgets/common_loading_view.dart';
import 'package:qr_scanner_practice/feature/ocr/presentation/bloc/ocr_bloc.dart';
import 'package:qr_scanner_practice/feature/ocr/presentation/widgets/ocr_screen_content_view.dart';

@RoutePage()
class OcrScreen extends StatelessWidget {
  const OcrScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return BlocProvider<OcrBloc>(
      create: (_) => AppInjector.getIt<OcrBloc>(),
      child: const OcrScreenView(),
    );
  }
}

class OcrScreenView extends StatelessWidget {
  const OcrScreenView({super.key});

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: context.locale.extractTextOcr),
      backgroundColor: context.appColors.scaffoldBackground,
      body: BlocListener<OcrBloc, OcrState>(
        listener: (final BuildContext context, final OcrState state) {
          if (state is OcrErrorState) {
            ToastUtils.showToast(context, state.message, isSuccess: false);
          }
          if (state is OcrSuccessState) {
            final ImageProvider previewImage = FileImage(
              state.ocrResultEntity.imageFile,
            );

            context.router
                .push(
                  ScanResultRoute(
                    scanResult: state.ocrResultEntity.recognizedText,
                    resultType: ResultType.ocr,
                    previewImage: previewImage,
                  ),
                )
                .then((_) {
                  if (context.mounted) {
                    context.read<OcrBloc>().add(const ClearOcrResultEvent());
                  }
                });
          }
        },
        child: BlocBuilder<OcrBloc, OcrState>(
          builder: (final BuildContext context, final OcrState state) {
            return switch (state) {
              OcrLoadingState() => const CommonLoadingView(),
              OcrImagePickedState() ||
              OcrSuccessState() ||
              OcrErrorState() ||
              OcrInitialState() => const OcrScreenContentView(),
            };
          },
        ),
      ),
    );
  }
}
