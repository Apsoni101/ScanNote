part of 'settings_bloc.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object?> get props => <Object?>[];
}

final class SettingsLoading extends SettingsState {
  const SettingsLoading();
}

final class SettingsLoaded extends SettingsState {
  const SettingsLoaded({
    required this.user,
    required this.themeName,
    required this.languageCode,
  });

  final UserEntity user;
  final String themeName;
  final String languageCode;

  @override
  List<Object?> get props => <Object?>[user, themeName, languageCode];

  SettingsLoaded copyWith({
    final UserEntity? user,
    final String? themeName,
    final String? languageCode,
  }) {
    return SettingsLoaded(
      user: user ?? this.user,
      themeName: themeName ?? this.themeName,
      languageCode: languageCode ?? this.languageCode,
    );
  }
}

final class SignOutSuccess extends SettingsState {
  const SignOutSuccess();
}

final class SettingsError extends SettingsState {
  const SettingsError({required this.message});

  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}
