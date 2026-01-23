import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner_practice/feature/auth/domain/entities/user_entity.dart';
import 'package:qr_scanner_practice/feature/setting/domain/usecase/settings_usecase.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({required this.settingsUseCase}) : super(const SettingsLoading()) {
    on<LoadSettingsEvent>(_onLoadSettings);
    on<SignOutEvent>(_onSignOut);
    on<SaveThemeModeEvent>(_onSaveThemeMode);
    on<SaveLanguageEvent>(_onSaveLanguage);
  }

  final SettingsUseCase settingsUseCase;

  Future<void> _onLoadSettings(
      LoadSettingsEvent event,
      Emitter<SettingsState> emit,
      ) async {
    emit(const SettingsLoading());

    final userResult = await settingsUseCase.getCurrentUser();
    final themeName = settingsUseCase.getThemeMode();
    final languageCode = settingsUseCase.getLanguage();

    userResult.fold(
          (failure) => emit(SettingsError(message: failure.message)),
          (user) => emit(SettingsLoaded(
        user: user,
        themeName: themeName,
        languageCode: languageCode,
      )),
    );
  }

  Future<void> _onSignOut(
      SignOutEvent event,
      Emitter<SettingsState> emit,
      ) async {
    emit(const SettingsLoading());

    final result = await settingsUseCase.signOut();

    result.fold(
          (failure) => emit(SettingsError(message: failure.message)),
          (_) => emit(const SignOutSuccess()),
    );
  }

  Future<void> _onSaveThemeMode(
      SaveThemeModeEvent event,
      Emitter<SettingsState> emit,
      ) async {
    await settingsUseCase.saveThemeMode(event.themeName);

    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      emit(currentState.copyWith(themeName: event.themeName));
    }
  }

  Future<void> _onSaveLanguage(
      SaveLanguageEvent event,
      Emitter<SettingsState> emit,
      ) async {
    await settingsUseCase.saveLanguage(event.languageCode);

    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      emit(currentState.copyWith(languageCode: event.languageCode));
    }
  }
}