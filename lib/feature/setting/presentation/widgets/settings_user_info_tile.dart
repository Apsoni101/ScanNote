import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/constants/asset_constants.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';
import 'package:qr_scanner_practice/feature/setting/presentation/bloc/settings_bloc.dart';

class SettingsUserInfoTile extends StatelessWidget {
  const SettingsUserInfoTile({super.key});

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (final BuildContext context, final SettingsState state) {
        return switch (state) {
          SettingsLoading() => Image.asset(AppAssets.codeIsArtLoading),
          SettingsError() => ListTile(
            contentPadding: const .symmetric(vertical: 12, horizontal: 14),
            leading: CircleAvatar(
              radius: 26,
              backgroundColor: context.appColors.primaryDefault,
              child: const Icon(Icons.error_outline),
            ),
            title: Text(
              context.locale.errorLoadingUser,
              style: AppTextStyles.airbnbCerealW500S16Lh24Ls0.copyWith(
                color: context.appColors.textPrimary,
              ),
            ),
            subtitle: Text(
              state.message,
              style: AppTextStyles.airbnbCerealW400S14Lh20Ls0.copyWith(
                color: context.appColors.textSecondary,
              ),
            ),
          ),
          SettingsLoaded() => ListTile(
            contentPadding: const .symmetric(vertical: 12, horizontal: 14),
            leading: CircleAvatar(
              radius: 26,
              backgroundColor: context.appColors.primaryDefault,
              child:
                  state.user.profilePicture != null &&
                      state.user.profilePicture!.isNotEmpty
                  ? ClipOval(
                      child: Image.network(
                        state.user.profilePicture!,
                        fit: .cover,
                        errorBuilder:
                            (
                              final BuildContext context,
                              final Object error,
                              final StackTrace? stackTrace,
                            ) {
                              return const Icon(Icons.person);
                            },
                      ),
                    )
                  : const Icon(Icons.person),
            ),
            title: Text(
              state.user.name ?? context.locale.user,
              style: AppTextStyles.airbnbCerealW500S16Lh24Ls0.copyWith(
                color: context.appColors.textPrimary,
              ),
            ),
            subtitle: Text(
              state.user.email ?? context.locale.noEmail,
              style: AppTextStyles.airbnbCerealW400S14Lh20Ls0.copyWith(
                color: context.appColors.textSecondary,
              ),
            ),
          ),
          SignOutSuccess() => ListTile(
            contentPadding: const .symmetric(vertical: 12, horizontal: 14),
            leading: CircleAvatar(
              radius: 26,
              backgroundColor: context.appColors.primaryDefault,
              child: const Icon(Icons.logout),
            ),
            title: Text(
              context.locale.signedOut,
              style: AppTextStyles.airbnbCerealW500S16Lh24Ls0.copyWith(
                color: context.appColors.textPrimary,
              ),
            ),
            subtitle: Text(
              context.locale.youHaveBeenSignedOut,
              style: AppTextStyles.airbnbCerealW400S14Lh20Ls0.copyWith(
                color: context.appColors.textSecondary,
              ),
            ),
          ),
        };
      },
    );
  }
}
