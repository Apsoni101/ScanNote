import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner_practice/core/controller/theme_controller.dart';
import 'package:qr_scanner_practice/core/di/app_injector.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';
import 'package:qr_scanner_practice/feature/setting/presentation/bloc/settings_bloc.dart';

class SettingsThemeSwitch extends StatelessWidget {
  const SettingsThemeSwitch({super.key});

  @override
  Widget build(final BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Transform.scale(
      scale: 0.8,
      child: Switch(
        trackOutlineWidth: const WidgetStatePropertyAll<double>(0),
        trackOutlineColor: const WidgetStatePropertyAll<Color>(
          Colors.transparent,
        ),
        inactiveThumbColor: context.appColors.switchInactiveThumb,
        activeTrackColor: context.appColors.primaryDefault,
        activeThumbColor: context.appColors.switchActiveThumb,
        value: isDark,
        onChanged: (final bool value) {
          final ThemeController themeController =
              AppInjector.getIt<ThemeController>()..toggleTheme();
          final String themeName = themeController.themeName;
          context.read<SettingsBloc>().add(
            SaveThemeModeEvent(themeName: themeName),
          );
        },
      ),
    );
  }
}
