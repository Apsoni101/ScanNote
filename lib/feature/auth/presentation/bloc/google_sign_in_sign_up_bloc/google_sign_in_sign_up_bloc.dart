import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:qr_scanner_practice/feature/auth/domain/entities/user_entity.dart';
import 'package:qr_scanner_practice/feature/auth/domain/use_cases/google_sign_in_sign_up_remote_usecase.dart';

part 'google_sign_in_sign_up_event.dart';

part 'google_sign_in_sign_up_state.dart';

class GoogleSignInSignUpBloc
    extends Bloc<GoogleSignInSignUpEvent, GoogleSignInSignUpState> {
  GoogleSignInSignUpBloc({required this.authRemoteUseCase})
    : super(const LoginInitial()) {
    on<OnGoogleLoginEvent>(_onGoogleLoginEvent);
    on<LogoutEvent>(_onLogoutEvent);
  }

  final GoogleSignInSignUpRemoteUseCase authRemoteUseCase;

  Future<void> _onGoogleLoginEvent(
    final OnGoogleLoginEvent event,
    final Emitter<GoogleSignInSignUpState> emit,
  ) async {
    emit(const LoginLoading());

    final Either<Failure, UserEntity> result = await authRemoteUseCase
        .signInWithGoogle();

    await result.fold(
      (final Failure failure) async {
        if (failure is AuthenticationFailure) {
          switch (failure.message) {
            case 'auth.network':
              emit(const LoginNetworkError());
              break;

            case 'auth.userDisabled':
              emit(const LoginUserDisabledError());
              break;

            case 'auth.accountExists':
              emit(const LoginAccountExistsError());
              break;

            case 'auth.cancelled':
              emit(const LoginCancelled());
              break;

            default:
              emit(LoginUnknownError(failure.message));
          }
        } else {
          emit(LoginUnknownError(failure.message));
        }

        emit(const LoginInitial());
      },
      (final UserEntity user) async {
        emit(const LoginSuccess());
      },
    );
  }

  Future<void> _onLogoutEvent(
    final LogoutEvent event,
    final Emitter<GoogleSignInSignUpState> emit,
  ) async {
    emit(const LoginInitial());
  }
}
