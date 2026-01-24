import 'package:qr_scanner_practice/core/local_storage/hive_key_constants.dart';
import 'package:qr_scanner_practice/core/local_storage/hive_service.dart';

abstract class SettingsLocalDataSource {
  Future<void> saveThemeMode(final String themeName);

  String? getThemeMode();

  Future<void> saveLanguage(final String languageCode);

  String? getLanguage();
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  const SettingsLocalDataSourceImpl(this._hiveService);

  final HiveService _hiveService;

  @override
  Future<void> saveThemeMode(final String themeName) async {
    await _hiveService.setString(HiveKeyConstants.themeMode, themeName);
  }

  @override
  String? getThemeMode() {
    return _hiveService.getString(HiveKeyConstants.themeMode);
  }

  @override
  Future<void> saveLanguage(final String languageCode) async {
    await _hiveService.setString(HiveKeyConstants.language, languageCode);
  }

  @override
  String? getLanguage() {
    return _hiveService.getString(HiveKeyConstants.language);
  }
}
