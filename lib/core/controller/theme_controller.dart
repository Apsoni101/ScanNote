import 'package:flutter/material.dart';

class ThemeController extends ValueNotifier<ThemeMode> {
  ThemeController() : super(ThemeMode.system);

  /// Save theme to Hive
  Future<void> setTheme(final ThemeMode theme) async {
    value = theme;
  }

  String get themeName => value.name;

  /// Switch between light and dark
  Future<void> toggleTheme() async {
    if (value == ThemeMode.light) {
      await setTheme(ThemeMode.dark);
    } else {
      await setTheme(ThemeMode.light);
    }
  }
}
