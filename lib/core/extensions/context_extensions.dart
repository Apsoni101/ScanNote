import 'package:flutter/material.dart';
import 'package:qr_scanner_practice/core/app_theming/app_colors.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_scanner_practice/core/localisation/app_localizations.dart';

///extension for app colors to access app colors like this context.appColors.primary etc .
extension AppColorsExtension on BuildContext {
  AppThemeColors get appColors {
    final Brightness brightness = Theme.of(this).brightness;
    if (brightness == Brightness.dark) {
      return AppColorsDark();
    } else {
      return AppColorsLight();
    }
  }
}

/// extension for strings to access app strings  like this context.locale.appName
extension AppLocaleExtension on BuildContext {
  AppLocalizations get locale => AppLocalizations.of(this);
}
