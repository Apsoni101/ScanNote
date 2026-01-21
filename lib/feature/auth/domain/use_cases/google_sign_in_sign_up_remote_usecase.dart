import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:qr_scanner_practice/feature/auth/domain/entities/user_entity.dart';
import 'package:qr_scanner_practice/feature/auth/domain/repositories/google_sign_in_sign_up_remote_repo.dart';

/// Use case for remote authentication operations
class GoogleSignInSignUpRemoteUseCase {
  /// Creates an instance of GoogleSignInSignUpRemoteUseCase
  GoogleSignInSignUpRemoteUseCase({required this.authRemoteRepo});

  /// Remote authentication repository
  final GoogleSignInSignUpRemoteRepo authRemoteRepo;

  /// Signs in the user using Google authentication
  Future<Either<Failure, UserEntity>> signInWithGoogle() =>
      authRemoteRepo.signInWithGoogle();

  /// Signs out the currently authenticated user
  Future<Either<Failure, Unit>> signOut() => authRemoteRepo.signOut();

  /// Checks if user is signed in with remote service
  bool isSignedIn() => authRemoteRepo.isSignedIn();
}
