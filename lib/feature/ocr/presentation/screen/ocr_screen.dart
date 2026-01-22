import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/di/app_injector.dart';
import 'package:qr_scanner_practice/core/enums/result_type.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';
import 'package:qr_scanner_practice/core/navigation/app_router.gr.dart';
import 'package:qr_scanner_practice/feature/common/presentation/widgets/common_loading_view.dart';
import 'package:qr_scanner_practice/feature/ocr/presentation/bloc/ocr_bloc.dart';
import 'package:qr_scanner_practice/feature/ocr/presentation/widgets/ocr_content_view.dart';

@RoutePage()
class OcrScreen extends StatelessWidget {
  const OcrScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return BlocProvider<OcrBloc>(
      create: (_) => AppInjector.getIt<OcrBloc>(),
      child: const OcrView(),
    );
  }
}

class OcrView extends StatelessWidget {
  const OcrView({super.key});

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.locale.ocrTitle,
          style: AppTextStyles.airbnbCerealW700S24Lh32LsMinus1.copyWith(
            color: context.appColors.textPrimary,
          ),
        ),
        centerTitle: true,
        backgroundColor: context.appColors.textInversePrimary,
        elevation: 0,
      ),
      body: BlocListener<OcrBloc, OcrState>(
        listener: (final BuildContext context, final OcrState state) {
          if (state is OcrErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: AppTextStyles.airbnbCerealW500S14Lh20Ls0.copyWith(
                    color: context.appColors.textInversePrimary,
                  ),
                ),
                backgroundColor: context.appColors.semanticsIconError,
              ),
            );
          }

          if (state is OcrSuccessState) {
            context.router.push(
              ResultRoute(data: state.result, resultType: ResultType.ocr),
            );
            context.read<OcrBloc>().add(const ClearOcrResultEvent());
          }
        },
        child: BlocBuilder<OcrBloc, OcrState>(
          builder: (final BuildContext context, final OcrState state) {
            return switch (state) {
              OcrLoadingState() => const CommonLoadingView(),
              OcrImagePickedState() ||
              OcrSuccessState() ||
              OcrErrorState() ||
              OcrInitialState() => const OcrContentView(),
            };
          },
        ),
      ),
    );
  }
}
