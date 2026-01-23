import 'package:flutter/material.dart';
import 'package:qr_scanner_practice/core/enums/language_enum.dart';

class LanguageController extends ValueNotifier<LanguageEnum> {
  LanguageController() : super(LanguageEnum.english);

  /// Save language
  Future<void> setLanguage(final LanguageEnum language) async {
    value = language;

  }
  /// Get current language name
  String get languageName => value.name;
}
