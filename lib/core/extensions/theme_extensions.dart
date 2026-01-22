import 'package:flutter/material.dart';
import 'package:qr_scanner_practice/core/app_theming/app_color_theme_extension.dart';
import 'package:qr_scanner_practice/core/app_theming/app_light_theme_colors.dart';

/// this extension will help me to access my appColors using Theme.of(context).appColors
extension AppThemeExtension on ThemeData {
  AppColorThemeExtension get appThemeColors =>
      extension<AppColorThemeExtension>() ?? AppLightThemeColors();
}

///  simplified this extension usage more by applying extension on context residing in extensions of context extensions
