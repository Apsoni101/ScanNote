import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_scanner_practice/core/firebase/firebase_auth_service.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:qr_scanner_practice/feature/auth/data/models/user_model.dart';

abstract class GoogleSignInSignUpRemoteDataSource {
  Future<Either<Failure, Unit>> signOut();

  Future<Either<Failure, UserModel>> signInWithGoogle();

  bool isSignedIn();
}

class GoogleSignInSignUpRemoteDataSourceImpl
    implements GoogleSignInSignUpRemoteDataSource {
  GoogleSignInSignUpRemoteDataSourceImpl({required this.authService});

  final FirebaseAuthService authService;

  @override
  Future<Either<Failure, UserModel>> signInWithGoogle() async {
    final Either<Failure, User> result = await authService.signInWithGoogle();

    return result.fold(
      (final Failure failure) {
        return Left<Failure, UserModel>(failure);
      },
      (final User user) {
        try {
          final UserModel userModel = .fromFirebaseUser(user);
          return Right<Failure, UserModel>(userModel);
        } catch (e) {
          return Left<Failure, UserModel>(
            Failure(message: 'Failed to parse Firebase user: $e'),
          );
        }
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> signOut() => authService.signOut();

  @override
  bool isSignedIn() => authService.auth.currentUser != null;
}
