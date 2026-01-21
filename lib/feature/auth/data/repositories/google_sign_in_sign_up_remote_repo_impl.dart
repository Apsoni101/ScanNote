import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:qr_scanner_practice/feature/auth/data/data_sources/google_sign_in_sign_up_remote_datasource.dart';
import 'package:qr_scanner_practice/feature/auth/domain/entities/user_entity.dart';
import 'package:qr_scanner_practice/feature/auth/domain/repositories/google_sign_in_sign_up_remote_repo.dart';

/// Remote repository implementation for authentication operations
class GoogleSignInSignUpRemoteRepoImpl implements GoogleSignInSignUpRemoteRepo {
  /// Creates an instance of GoogleSignInSignUpRemoteRepoImpl
  GoogleSignInSignUpRemoteRepoImpl({required this.authRemoteDataSource});

  /// Remote data source for performing authentication operations
  final GoogleSignInSignUpRemoteDataSource authRemoteDataSource;

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() =>
      authRemoteDataSource.signInWithGoogle();

  @override
  Future<Either<Failure, Unit>> signOut() => authRemoteDataSource.signOut();

  @override
  bool isSignedIn() => authRemoteDataSource.isSignedIn();
}
