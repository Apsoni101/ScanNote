import 'package:flutter/material.dart';
import 'package:qr_scanner_practice/core/enums/language_enum.dart';

typedef AppSettings = (ThemeMode, LanguageEnum);

class AppSettingsController extends ValueNotifier<AppSettings> {
  AppSettingsController() : super((.system, .english));

  /// Initializing from storage
  void initialize({
    required final ThemeMode themeMode,
    required final LanguageEnum language,
  }) {
    value = (themeMode, language);
  }

  ThemeMode get themeMode => value.$1;

  LanguageEnum get language => value.$2;

  void setTheme(final ThemeMode mode) {
    value = (mode, value.$2);
  }

  void setLanguage(final LanguageEnum language) {
    value = (value.$1, language);
  }

  void toggleTheme() {
    final ThemeMode current = value.$1;

    final ThemeMode nextTheme = current == .dark ? .light : .dark;

    value = (nextTheme, value.$2);
  }
}
