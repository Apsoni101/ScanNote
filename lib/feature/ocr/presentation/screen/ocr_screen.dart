import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/di/app_injector.dart';
import 'package:qr_scanner_practice/core/extensions/color_extension.dart';
import 'package:qr_scanner_practice/core/extensions/localization_extension.dart';
import 'package:qr_scanner_practice/core/navigation/app_router.gr.dart';
import 'package:qr_scanner_practice/feature/ocr/presentation/bloc/ocr_bloc.dart';
import 'package:qr_scanner_practice/feature/result_scan/presentation/presentation/result_screen.dart';

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
            color: context.appColors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: context.appColors.white,
        elevation: 0,
      ),
      body: BlocListener<OcrBloc, OcrState>(
        listener: (final BuildContext context, final Object? state) {
          if (state is OcrErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: AppTextStyles.airbnbCerealW500S14Lh20Ls0.copyWith(
                    color: context.appColors.white,
                  ),
                ),
                backgroundColor: context.appColors.red,
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
        child: BlocSelector<OcrBloc, OcrState, OcrStateType>(
          selector: (final Object? state) {
            if (state is OcrLoadingState) {
              return OcrStateType.loading;
            }
            if (state is OcrSuccessState) {
              return OcrStateType.success;
            }
            if (state is OcrErrorState) {
              return OcrStateType.error;
            }
            return OcrStateType.initial;
          },
          builder: (final BuildContext context, final OcrStateType stateType) {
            switch (stateType) {
              case OcrStateType.loading:
                return const _LoadingView();
              case OcrStateType.success:
              case OcrStateType.error:
              case OcrStateType.initial:
                return const _InitialView();
            }
          },
        ),
      ),
    );
  }
}

enum OcrStateType { initial, loading, success, error }

/// ============================================
/// INITIAL VIEW
/// ============================================
class _InitialView extends StatelessWidget {
  const _InitialView();

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
        const _ActionButtons(),
      ],
    );
  }
}

/// ============================================
/// LOADING VIEW
/// ============================================
class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(final BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          context.appColors.primaryBlue,
        ),
      ),
    );
  }
}

/// ============================================
/// ACTION BUTTONS
/// ============================================
class _ActionButtons extends StatelessWidget {
  const _ActionButtons();

  @override
  Widget build(final BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              context.read<OcrBloc>().add(const PickImageFromCameraEvent());
            },
            icon: Icon(Icons.camera_alt, color: context.appColors.white),
            label: Text(
              context.locale.cameraButtonLabel,
              style: AppTextStyles.airbnbCerealW500S14Lh20Ls0.copyWith(
                color: context.appColors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: context.appColors.primaryBlue,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              context.read<OcrBloc>().add(const PickImageFromGalleryEvent());
            },
            icon: Icon(Icons.photo_library, color: context.appColors.white),
            label: Text(
              context.locale.galleryButtonLabel,
              style: AppTextStyles.airbnbCerealW500S14Lh20Ls0.copyWith(
                color: context.appColors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: context.appColors.primaryBlue,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ],
    );
  }
}
