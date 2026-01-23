part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => <Object?>[];
}

final class LoadSettingsEvent extends SettingsEvent {
  const LoadSettingsEvent();
}

final class SignOutEvent extends SettingsEvent {
  const SignOutEvent();
}

final class SaveThemeModeEvent extends SettingsEvent {
  const SaveThemeModeEvent({required this.themeName});

  final String themeName;

  @override
  List<Object?> get props => <Object?>[themeName];
}

final class SaveLanguageEvent extends SettingsEvent {
  const SaveLanguageEvent({required this.languageCode});

  final String languageCode;

  @override
  List<Object?> get props => <Object?>[languageCode];
}
