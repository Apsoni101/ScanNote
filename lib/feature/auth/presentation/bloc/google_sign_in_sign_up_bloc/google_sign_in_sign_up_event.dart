part of 'google_sign_in_sign_up_bloc.dart';

@immutable
sealed class GoogleSignInSignUpEvent extends Equatable {
  const GoogleSignInSignUpEvent();

  @override
  List<Object?> get props => <Object>[];
}

final class OnGoogleLoginEvent extends GoogleSignInSignUpEvent {
  const OnGoogleLoginEvent();

  @override
  List<Object?> get props => <Object>[];
}

final class LogoutEvent extends GoogleSignInSignUpEvent {
  const LogoutEvent();
}
