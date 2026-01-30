import 'package:flutter/material.dart';
import 'package:qr_scanner_practice/core/app_theming/app_color_theme_extension.dart';
import 'package:qr_scanner_practice/core/app_theming/app_light_theme_colors.dart';
import 'package:qr_scanner_practice/core/localisation/app_localizations.dart';

/// extension for strings to access app strings  like this context.locale.appName
extension AppLocaleExtension on BuildContext {
  AppLocalizations get locale => .of(this);
}

extension AppColorsContextExtension on BuildContext {
  AppColorThemeExtension get appColors =>
      Theme.of(this).extension<AppColorThemeExtension>() ??
      AppLightThemeColors();
}
