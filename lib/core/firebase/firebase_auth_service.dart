import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';

/// Firebase service similar to network service
class FirebaseAuthService {
  FirebaseAuthService({
    final FirebaseAuth? auth,
    final GoogleSignIn? googleSignIn,
  }) : auth = auth ?? FirebaseAuth.instance,
       googleSignIn =
           googleSignIn ??
           GoogleSignIn(
             scopes: <String>[
               'https://www.googleapis.com/auth/spreadsheets',
               'https://www.googleapis.com/auth/drive',
             ],
           );

  /// Firebase auth instance
  final FirebaseAuth auth;

  /// Google Sign In instance
  final GoogleSignIn googleSignIn;

  /// Used for signing out user
  Future<Either<Failure, Unit>> signOut() async {
    try {
      await googleSignIn.signOut();
      await auth.signOut();
      return const Right<Failure, Unit>(unit);
    } on FirebaseAuthException catch (e) {
      return Left<Failure, Unit>(
        Failure(
          message: 'Firebase error: ${e.message} \n errorCode: ${e.code}',
        ),
      );
    } on FirebaseException catch (e) {
      return Left<Failure, Unit>(
        Failure(
          message: 'Firebase error: ${e.message} \n errorCode: ${e.code}',
        ),
      );
    } on Exception catch (e) {
      return Left<Failure, Unit>(Failure(message: 'Unexpected error: $e'));
    }
  }

  /// Used for sign in with Google
  Future<Either<Failure, User>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        return Left<Failure, User>(
          Failure(message: 'Google sign in cancelled'),
        );
      }

      final GoogleSignInAuthentication? googleAuth =
          await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final UserCredential result = await auth.signInWithCredential(credential);
      return Right<Failure, User>(result.user!);
    } on FirebaseAuthException catch (e) {
      return Left<Failure, User>(
        Failure(
          message: 'Firebase error: ${e.message} \n errorCode: ${e.code}',
        ),
      );
    } on FirebaseException catch (e) {
      return Left<Failure, User>(
        Failure(
          message: 'Firebase error: ${e.message} \n errorCode: ${e.code}',
        ),
      );
    } on Exception catch (e) {
      return Left<Failure, User>(Failure(message: 'Unexpected error: $e'));
    }
  }

  /// Check if user is signed in
  Future<Either<Failure, bool>> isSignedIn() async {
    try {
      return Right<Failure, bool>(auth.currentUser != null);
    } on FirebaseAuthException catch (e) {
      return Left<Failure, bool>(
        Failure(
          message: 'Firebase error: ${e.message} \n errorCode: ${e.code}',
        ),
      );
    } on FirebaseException catch (e) {
      return Left<Failure, bool>(
        Failure(
          message: 'Firebase error: ${e.message} \n errorCode: ${e.code}',
        ),
      );
    } on Exception catch (e) {
      return Left<Failure, bool>(Failure(message: 'Unexpected error: $e'));
    }
  }

  /// Used to get currently signed-in user id
  Future<Either<Failure, String>> getCurrentUserId() async {
    try {
      final User? user = auth.currentUser;

      if (user == null) {
        return const Left<Failure, String>(
          Failure(message: 'No user is currently signed in'),
        );
      }

      return Right<Failure, String>(user.uid);
    } on FirebaseAuthException catch (e) {
      return Left<Failure, String>(
        Failure(
          message: 'Firebase error: ${e.message} \n errorCode: ${e.code}',
        ),
      );
    } on FirebaseException catch (e) {
      return Left<Failure, String>(
        Failure(
          message: 'Firebase error: ${e.message} \n errorCode: ${e.code}',
        ),
      );
    } on Exception catch (e) {
      return Left<Failure, String>(Failure(message: 'Unexpected error: $e'));
    }
  }

  /// Get Google OAuth 2.0 access token for Google Sheets API
  /// This token has permission to access Google Sheets and Drive APIs
  Future<Either<Failure, String>> getGoogleAccessToken() async {
    try {
      // Try to restore previous sign-in session silently
      GoogleSignInAccount? googleUser = googleSignIn.currentUser;

      if (googleUser == null) {
        googleUser = await googleSignIn.signInSilently();
      }

      if (googleUser == null) {
        return const Left<Failure, String>(
          Failure(message: 'No Google account signed in'),
        );
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final String? accessToken = googleAuth.accessToken;

      if (accessToken == null || accessToken.isEmpty) {
        return const Left<Failure, String>(
          Failure(message: 'Failed to retrieve Google access token'),
        );
      }

      return Right<Failure, String>(accessToken);
    } on FirebaseAuthException catch (e) {
      return Left<Failure, String>(
        Failure(
          message: 'Firebase error: ${e.message} \n errorCode: ${e.code}',
        ),
      );
    } on FirebaseException catch (e) {
      return Left<Failure, String>(
        Failure(
          message: 'Firebase error: ${e.message} \n errorCode: ${e.code}',
        ),
      );
    } on Exception catch (e) {
      return Left<Failure, String>(Failure(message: 'Unexpected error: $e'));
    }
  }
}
