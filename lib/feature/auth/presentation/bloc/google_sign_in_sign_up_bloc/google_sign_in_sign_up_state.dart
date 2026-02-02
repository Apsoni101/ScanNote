part of 'google_sign_in_sign_up_bloc.dart';

@immutable
sealed class GoogleSignInSignUpState extends Equatable {
  const GoogleSignInSignUpState();

  @override
  List<Object?> get props => <Object>[];
}

final class LoginInitial extends GoogleSignInSignUpState {
  const LoginInitial();
}

final class LoginLoading extends GoogleSignInSignUpState {
  const LoginLoading();
}

final class LoginSuccess extends GoogleSignInSignUpState {
  const LoginSuccess();

  @override
  List<Object?> get props => <Object?>[];
}

class LoginUnknownError extends GoogleSignInSignUpState {
  const LoginUnknownError();
}

/// 🌐 No internet
class LoginNetworkError extends GoogleSignInSignUpState {
  const LoginNetworkError();
}

/// 👤 Account disabled
class LoginUserDisabledError extends GoogleSignInSignUpState {
  const LoginUserDisabledError();
}

/// 🔐 Account exists with different credential
class LoginAccountExistsError extends GoogleSignInSignUpState {
  const LoginAccountExistsError();
}

/// ❌ User cancelled login
class LoginCancelled extends GoogleSignInSignUpState {
  const LoginCancelled();
}
