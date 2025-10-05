import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:foody_licious_admin_app/domain/entities/restaurant/restaurant.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_up_with_email_usecase.dart';

import '../../../core/error/failures.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpWithEmailUseCase _signUpWithEmailUseCase;
 
  AuthBloc(
    this._signUpWithEmailUseCase,
  ) : super(AuthInitial()) {
    on<AuthSignUpWithEmail>(_onSignUpWithEmail);
    on<AuthCheck>(_onCheckAuth);
   }

  FutureOr<void> _onSignUpWithEmail(
      AuthSignUpWithEmail event, Emitter<AuthState> emit) async {
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
