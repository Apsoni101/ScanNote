import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:qr_scanner_practice/feature/auth/domain/entities/user_entity.dart';

/// Abstract repository for remote authentication operations
abstract class GoogleSignInSignUpRemoteRepo {
  /// Signs in the user using Google authentication
  Future<Either<Failure, UserEntity>> signInWithGoogle();

  /// Signs out the currently authenticated user
  Future<Either<Failure, Unit>> signOut();

  /// Checks if user is signed in with remote service
  bool isSignedIn();
}
