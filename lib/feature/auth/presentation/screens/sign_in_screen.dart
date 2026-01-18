import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/constants/asset_constants.dart';
import 'package:qr_scanner_practice/core/di/app_injector.dart';
import 'package:qr_scanner_practice/core/extensions/color_extension.dart';
import 'package:qr_scanner_practice/core/extensions/localization_extension.dart';
import 'package:qr_scanner_practice/core/navigation/app_router.gr.dart';
import 'package:qr_scanner_practice/feature/auth/presentation/bloc/login_bloc/login_bloc.dart';

@RoutePage()
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(final BuildContext context) => BlocProvider<LoginBloc>(
    create: (final BuildContext context) => AppInjector.getIt<LoginBloc>(),
    child: BlocListener<LoginBloc, LoginState>(
      listener: (final BuildContext context, final LoginState state) async {
        if (state is LoginError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
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
        backgroundColor: context.appColors.cF6F9FF,
        body: BlocBuilder<LoginBloc, LoginState>(
          builder: (final BuildContext context, final LoginState state) {
            final bool isLoading = state is LoginLoading;

            return Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.login,
                    size: 80,
                    color: context.appColors.primaryBlue,
                  ),
                  const SizedBox(height: 40),

                  Text(
                    context.locale.welcomeBack,
                    style: AppTextStyles.airbnbCerealW700S24Lh32LsMinus1
                        .copyWith(color: context.appColors.black),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    context.locale.signInWithGoogle,
                    style: AppTextStyles.airbnbCerealW400S14Lh20Ls0.copyWith(
                      color: context.appColors.slate,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),

                  // Google Sign In Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: isLoading
                          ? null
                          : () {
                              context.read<LoginBloc>().add(
                                const OnGoogleLoginEvent(),
                              );
                            },
                      icon: isLoading
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  context.appColors.white,
                                ),
                              ),
                            )
                          : SvgPicture.asset(
                              AppAssets.googleIc,
                              height: 24,
                              width: 24,
                            ),
                      label: Text(
                        isLoading
                            ? context.locale.signingIn
                            : context.locale.signInWithGoogle,
                        style: AppTextStyles.airbnbCerealW500S14Lh20Ls0
                            .copyWith(color: context.appColors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.appColors.white,
                        foregroundColor: context.appColors.black,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: context.appColors.cEAECF0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ),
  );
}
