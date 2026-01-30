import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_scanner_practice/core/firebase/firebase_auth_service.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:qr_scanner_practice/feature/auth/data/models/user_model.dart';

abstract class SettingsRemoteDataSource {
  /// Get currently signed-in user
  Future<Either<Failure, UserModel>> getCurrentUser();

  /// Sign out user
  Future<Either<Failure, Unit>> signOut();
}

class SettingsRemoteDataSourceImpl implements SettingsRemoteDataSource {
  SettingsRemoteDataSourceImpl({required this.firebaseAuthService});

  final FirebaseAuthService firebaseAuthService;

  @override
  Future<Either<Failure, UserModel>> getCurrentUser() async {
    final Either<Failure, User> result = await firebaseAuthService
        .getCurrentUser();

    return result.fold(
      Left.new,
      (final User user) => Right<Failure, UserModel>(.fromFirebaseUser(user)),
    );
  }

  @override
  Future<Either<Failure, Unit>> signOut() => firebaseAuthService.signOut();
}
