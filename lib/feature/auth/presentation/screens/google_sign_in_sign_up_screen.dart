import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/constants/asset_constants.dart';
import 'package:qr_scanner_practice/core/di/app_injector.dart';

import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';

import 'package:qr_scanner_practice/core/navigation/app_router.gr.dart';
import 'package:qr_scanner_practice/core/utils/toast_utils.dart';
import 'package:qr_scanner_practice/feature/auth/presentation/bloc/google_sign_in_sign_up_bloc/google_sign_in_sign_up_bloc.dart';
import 'package:qr_scanner_practice/feature/common/presentation/widgets/elevated_svg_icon_button.dart';

@RoutePage()
class GoogleSignInSignUpScreen extends StatefulWidget {
  const GoogleSignInSignUpScreen({super.key});

  @override
  State<GoogleSignInSignUpScreen> createState() =>
      _GoogleSignInSignUpScreenState();
}

class _GoogleSignInSignUpScreenState extends State<GoogleSignInSignUpScreen> {
  @override
  Widget build(final BuildContext context) {
    return BlocProvider<GoogleSignInSignUpBloc>(
      create: (final BuildContext context) =>
          AppInjector.getIt<GoogleSignInSignUpBloc>(),
      child: BlocListener<GoogleSignInSignUpBloc, GoogleSignInSignUpState>(
        listener:
            (
              final BuildContext context,
              final GoogleSignInSignUpState state,
            ) async {
              if (state is LoginNetworkError) {
                _show(context, context.locale.noInternetConnection);
              }

              if (state is LoginUserDisabledError) {
                _show(context, context.locale.yourAccountHasBeenDisabled);
              }

              if (state is LoginAccountExistsError) {
                _show(
                  context,
                  context.locale.emailAlreadyLinkedToAnotherAccount,
                );
              }

              if (state is LoginCancelled) {
                _show(context, context.locale.signInCancelled);
              }

              if (state is LoginUnknownError) {
                _show(context, state.message);
              }
              if (state is LoginSuccess) {
                await context.router.replace(
                  const DashboardRouter(
                    children: <PageRouteInfo<Object?>>[HomeRoute()],
                  ),
                );
              }
            },
        child: Scaffold(
          backgroundColor: context.appColors.scaffoldBackground,
          body: Padding(
            padding: const .symmetric(vertical: 32, horizontal: 24),
            child: Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: .stretch,
              children: <Widget>[
                const Spacer(),
                Image.asset(
                  AppAssets.appLogoRoundedCorners,
                  height: MediaQuery.heightOf(context) * 0.14,
                ),
                const SizedBox(height: 20),
                Text(
                  context.locale.appName,
                  style: AppTextStyles.interW600S36Lh48Ls0.copyWith(
                    color: context.appColors.textPrimary,
                  ),
                  textAlign: .center,
                ),
                const SizedBox(height: 8),
                Text(
                  context.locale.scanExtractSave,
                  style: AppTextStyles.airbnbCerealW400S14Lh20Ls0.copyWith(
                    color: context.appColors.textSecondary,
                  ),
                  textAlign: .center,
                ),
                const SizedBox(height: 32),
                Text(
                  context.locale.welcome,
                  style: AppTextStyles.airbnbCerealW600S20Lh28Ls0.copyWith(
                    color: context.appColors.textPrimary,
                  ),
                  textAlign: .center,
                ),
                const SizedBox(height: 8),
                Text(
                  context.locale.signInToSyncYourScansAcrossDevices,
                  style: AppTextStyles.airbnbCerealW400S14Lh20Ls0.copyWith(
                    color: context.appColors.textSecondary,
                  ),
                  textAlign: .center,
                ),
                const SizedBox(height: 16),
                BlocSelector<
                  GoogleSignInSignUpBloc,
                  GoogleSignInSignUpState,
                  bool
                >(
                  selector: (final GoogleSignInSignUpState state) =>
                      state is LoginLoading,
                  builder: (final BuildContext context, final bool isLoading) {
                    return ElevatedSvgIconButton(
                      isLoading: isLoading,
                      icon: AppAssets.googleIc,
                      label: context.locale.continueWithGoogle,
                      backgroundColor: context.appColors.primaryDefault,
                      onPressed: () {
                        context.read<GoogleSignInSignUpBloc>().add(
                          const OnGoogleLoginEvent(),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  context
                      .locale
                      .newUserSameButtonCreatesYourAccountAutomatically,
                  style: AppTextStyles.airbnbCerealW400S12Lh16Ls0.copyWith(
                    color: context.appColors.textSecondary,
                  ),
                  textAlign: .center,
                ),
                const Spacer(),
                Text(
                  context
                      .locale
                      .byContinuingYouAgreeToOurTermsOfServiceAndPrivacyPolicy,
                  style: AppTextStyles.interW400S12Lh16Ls0.copyWith(
                    color: context.appColors.textSecondary,
                  ),
                  textAlign: .center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _show(final BuildContext context, final String text) {
    ToastUtils.showToast(context, text, isSuccess: false);
  }
}
