import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:foody_licious_admin_app/domain/entities/restaurant/restaurant.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_in_with_email_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_in_with_facebook_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_in_with_google_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_up_with_email_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_up_with_facebook_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_up_with_google_usecase.dart';

import '../../../core/error/failures.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithEmailUseCase _signInWithEmailUseCase;
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;
  final SignInWithFacebookUseCase _signInWithFacebookUseCase;
  final SignUpWithEmailUseCase _signUpWithEmailUseCase;
  final SignUpWithGoogleUseCase _signUpWithGoogleUseCase;
  final SignUpWithFacebookUseCase _signUpWithFacebookUseCase;

  AuthBloc(
    this._signInWithEmailUseCase,
    this._signInWithGoogleUseCase,
    this._signInWithFacebookUseCase,
    this._signUpWithEmailUseCase,
    this._signUpWithGoogleUseCase,
    this._signUpWithFacebookUseCase,
  ) : super(AuthInitial()) {
    on<AuthSignInWithEmail>(_onSignInWithEmail);
    on<AuthSignInWithGoogle>(_onSignInWithGoogle);
    on<AuthSignInWithFacebook>(_onSignInWithFacebook);
    on<AuthSignUpWithEmail>(_onSignUpWithEmail);
    on<AuthSignUpWithGoogle>(_onSignUpWithGoogle);
    on<AuthSignUpWithFacebook>(_onSignUpWithFacebook);
    on<AuthCheck>(_onCheckAuth);
  }

  void _onSignInWithEmail(
    AuthSignInWithEmail event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());
      final result = await _signInWithEmailUseCase(event.params);
      result.fold(
        (failure) => emit(AuthSignInWithEmailFailed(failure)),
        (user) => emit(AuthSignInWithEmailSuccess(user)),
      );
    } catch (e) {
      emit(AuthSignInWithEmailFailed(ExceptionFailure(e.toString())));
    }
  }

  FutureOr<void> _onSignInWithGoogle(
    AuthSignInWithGoogle event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());
      final result = await _signInWithGoogleUseCase(event);
      result.fold(
        (failure) => emit(AuthGoogleSignInFailed(failure)),
        (user) => emit(AuthGoogleSignInSuccess(user)),
      );
    } catch (e) {
      emit(AuthGoogleSignInFailed(ExceptionFailure(e.toString())));
    }
  }

  FutureOr<void> _onSignInWithFacebook(
    AuthSignInWithFacebook event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());
      final result = await _signInWithFacebookUseCase(event);
      result.fold(
        (failure) => emit(AuthFacebookSignInFailed(failure)),
        (user) => emit(AuthFacebookSignInSuccess(user)),
      );
    } catch (e) {
      emit(AuthFacebookSignInFailed(ExceptionFailure(e.toString())));
    }
  }

  FutureOr<void> _onSignUpWithEmail(
    AuthSignUpWithEmail event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());
      final result = await _signUpWithEmailUseCase(event.params);
      result.fold(
        (failure) => emit(AuthVerificationEmailRequestFailed(failure)),
        (user) => emit(AuthVerificationEmailRequested(user)),
      );
    } catch (e) {
      emit(AuthVerificationEmailRequestFailed(ExceptionFailure(e.toString())));
    }
  }

  FutureOr<void> _onSignUpWithGoogle(
    AuthSignUpWithGoogle event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());
      final result = await _signUpWithGoogleUseCase(event);
      result.fold(
        (failure) => emit(AuthGoogleSignUpFailed(failure)),
        (user) => emit(AuthGoogleSignUpSuccess(user)),
      );
    } catch (e) {
      emit(AuthGoogleSignUpFailed(ExceptionFailure(e.toString())));
    }
  }

  FutureOr<void> _onSignUpWithFacebook(
    AuthSignUpWithFacebook event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());
      final result = await _signUpWithFacebookUseCase(event);
      result.fold(
        (failure) => emit(AuthFacebookSignUpFailed(failure)),
        (user) => emit(AuthFacebookSignUpSuccess(user)),
      );
    } catch (e) {
      emit(AuthFacebookSignUpFailed(ExceptionFailure(e.toString())));
    }
  }

  void _onCheckAuth(AuthCheck event, Emitter<AuthState> emit) async {
    try {
      // emit(AuthLoading());
      // final result = await _getCachedAuthUseCase(NoParams());
      // result.fold(
      //   (failure) => emit(AuthLoggedFail(failure)),
      //   (user) => emit(AuthLogged(user)),
      // );
    } catch (e) {
      emit(AuthLoggedFail(ExceptionFailure(e.toString())));
    }
  }
}
