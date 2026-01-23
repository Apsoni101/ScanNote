import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/constants/asset_constants.dart';
import 'package:qr_scanner_practice/core/controller/theme_controller.dart';
import 'package:qr_scanner_practice/core/di/app_injector.dart';
import 'package:qr_scanner_practice/core/enums/language_enum.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';
import 'package:qr_scanner_practice/core/navigation/app_router.gr.dart';
import 'package:qr_scanner_practice/feature/common/presentation/widgets/padded_text.dart';
import 'package:qr_scanner_practice/feature/setting/presentation/bloc/settings_bloc.dart';
import 'package:qr_scanner_practice/feature/setting/presentation/widgets/language_selection_dialog.dart';
import 'package:qr_scanner_practice/feature/setting/presentation/widgets/settings_about_text_button_tile.dart';
import 'package:qr_scanner_practice/feature/setting/presentation/widgets/settings_action_tile.dart';
import 'package:qr_scanner_practice/feature/setting/presentation/widgets/settings_app_info_tile.dart';
import 'package:qr_scanner_practice/feature/setting/presentation/widgets/settings_section_card_content.dart';
import 'package:qr_scanner_practice/feature/setting/presentation/widgets/settings_theme_switch.dart';
import 'package:qr_scanner_practice/feature/setting/presentation/widgets/settings_user_info_tile.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return BlocProvider<SettingsBloc>(
      create: (_) =>
          AppInjector.getIt<SettingsBloc>()..add(const LoadSettingsEvent()),
      child: Builder(
        builder: (final BuildContext context) {
          final bool isDark = Theme.of(context).brightness == Brightness.dark;

          return Scaffold(
            backgroundColor: context.appColors.scaffoldBackground,
            appBar: AppBar(
              titleSpacing: 0,
              backgroundColor: context.appColors.appBarBackground,
              title: Text(
                context.locale.settings,
                style: AppTextStyles.airbnbCerealW600S20Lh28Ls0.copyWith(
                  color: context.appColors.textPrimary,
                ),
              ),
            ),
            body: Column(
              children: <Widget>[
                ///app name and version
                const SettingsAppInfoTile(),
                Divider(height: 2, color: context.appColors.separator),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 16,
                    ),
                    children: <Widget>[
                      /// light theme and dark section
                      PaddedText(
                        text: context.locale.appearance,
                        style: AppTextStyles.airbnbCerealW600S14Lh20Ls0
                            .copyWith(color: context.appColors.textSecondary),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      const SizedBox(height: 12),
                      SettingsSectionCardContent(
                        child: SettingsActionTile(
                          title: context.locale.theme,
                          iconAsset: AppAssets.lightThemeIc,
                          onPressed: () {
                           final ThemeController themeController= AppInjector.getIt<ThemeController>()
                           ..toggleTheme();
                            final String themeName = themeController.themeName;
                            context.read<SettingsBloc>().add(
                              SaveThemeModeEvent(themeName: themeName),
                            );                          },
                          trailingTitle: isDark
                              ? context.locale.dark
                              : context.locale.light,
                          trailing: const SettingsThemeSwitch(),
                        ),
                      ),
                      const SizedBox(height: 24),

                      /// change language section
                      PaddedText(
                        text: context.locale.language,
                        style: AppTextStyles.airbnbCerealW600S14Lh20Ls0
                            .copyWith(color: context.appColors.textSecondary),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      const SizedBox(height: 12),
                      SettingsSectionCardContent(
                        child: SettingsActionTile(
                          title: context.locale.language,
                          iconAsset: AppAssets.languageGlobeIc,
                          onPressed: () {
                            showDialog<void>(
                              context: context,
                              builder: (final BuildContext dialogContext) {
                                return LanguageSelectionDialog(
                                  currentLanguage: LanguageEnum.english,
                                  onLanguageSelected:
                                      (final LanguageEnum language) {
                                        dialogContext.router.pop();
                                      },
                                );
                              },
                            );
                          },
                          trailingTitle: context.locale.english,
                        ),
                      ),
                      const SizedBox(height: 24),

                      ///user info section
                      PaddedText(
                        text: context.locale.account,
                        style: AppTextStyles.airbnbCerealW600S14Lh20Ls0
                            .copyWith(color: context.appColors.textSecondary),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      const SizedBox(height: 12),
                      const SettingsSectionCardContent(
                        child: SettingsUserInfoTile(),
                      ),
                      const SizedBox(height: 24),

                      /// app about section
                      PaddedText(
                        text: context.locale.about,
                        style: AppTextStyles.airbnbCerealW600S14Lh20Ls0
                            .copyWith(color: context.appColors.textSecondary),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      const SizedBox(height: 12),
                      SettingsSectionCardContent(
                        child: ListView(
                          shrinkWrap: true,
                          children: <Widget>[
                            SettingsAboutTextButtonTile(
                              title: context.locale.privacyPolicy,
                              onPressed: () {},
                            ),
                            Divider(
                              height: 1,
                              color: context.appColors.separator,
                            ),
                            SettingsAboutTextButtonTile(
                              title: context.locale.termsOfService,
                              onPressed: () {},
                            ),
                            Divider(
                              height: 1,
                              color: context.appColors.separator,
                            ),
                            SettingsAboutTextButtonTile(
                              title: context.locale.helpAndSupport,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      /// log out section with bloc listener to navigate to signin screen
                      PaddedText(
                        text: context.locale.logOut,
                        style: AppTextStyles.airbnbCerealW600S14Lh20Ls0
                            .copyWith(color: context.appColors.textSecondary),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      const SizedBox(height: 12),
                      BlocListener<SettingsBloc, SettingsState>(
                        listener:
                            (
                              final BuildContext context,
                              final SettingsState state,
                            ) {
                              if (state is SignOutSuccess) {
                                context.router.replaceAll(
                                  <PageRouteInfo<Object?>>[const AuthRouter()],
                                );
                              }
                            },
                        child: SettingsSectionCardContent(
                          child: SettingsActionTile(
                            title: context.locale.logOut,
                            iconAsset: AppAssets.logOutIc,
                            onPressed: () {
                              context.read<SettingsBloc>().add(
                                const SignOutEvent(),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
