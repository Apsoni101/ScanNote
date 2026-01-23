import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:qr_scanner_practice/feature/auth/domain/entities/user_entity.dart';
import 'package:qr_scanner_practice/feature/setting/data/data_source/settings_local_data_source.dart';
import 'package:qr_scanner_practice/feature/setting/data/data_source/settings_remote_data_source.dart';
import 'package:qr_scanner_practice/feature/setting/domain/repo/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final SettingsRemoteDataSource remoteDataSource;
  final SettingsLocalDataSource localDataSource;

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() =>
      remoteDataSource.getCurrentUser();

  @override
  Future<Either<Failure, Unit>> signOut() => remoteDataSource.signOut();

  @override
  Future<void> saveThemeMode(String themeName) =>
      localDataSource.saveThemeMode(themeName);

  @override
  String getThemeMode() =>
      localDataSource.getThemeMode() ?? 'system';

  @override
  Future<void> saveLanguage(String languageCode) =>
      localDataSource.saveLanguage(languageCode);

  @override
  String getLanguage() =>
      localDataSource.getLanguage() ?? 'en';
}