import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:qr_scanner_practice/feature/auth/domain/entities/user_entity.dart';

abstract class SettingsRepository {
  Future<Either<Failure, UserEntity>> getCurrentUser();

  Future<Either<Failure, Unit>> signOut();

  Future<void> saveThemeMode(final String themeName);

  String getThemeMode();

  Future<void> saveLanguage(final String languageCode);

  String getLanguage();
}
