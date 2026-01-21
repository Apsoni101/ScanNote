import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:qr_scanner_practice/core/firebase/firebase_auth_service.dart';
import 'package:qr_scanner_practice/core/navigation/app_router.gr.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';

class AuthGuard extends AutoRouteGuard {
  AuthGuard({required this.firebaseAuthService});

  final FirebaseAuthService firebaseAuthService;

  @override
  Future<void> onNavigation(
    final NavigationResolver resolver,
    final StackRouter router,
  ) async {
    final Either<Failure, bool> isSignedInResult = await firebaseAuthService
        .isSignedIn();

    await isSignedInResult.fold(
      (final Failure failure) async {
        await router.replace(const GoogleSignInSignUpRoute());
      },
      (final bool isSignedIn) async {
        if (isSignedIn) {
          resolver.next();
        } else {
          await router.replace(const GoogleSignInSignUpRoute());
        }
      },
    );

    debugPrint('🏁 AuthGuard: Navigation check completed\n');
  }
}
