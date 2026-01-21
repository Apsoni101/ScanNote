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

final class LoginError extends GoogleSignInSignUpState {
  const LoginError({required this.message});

  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}
