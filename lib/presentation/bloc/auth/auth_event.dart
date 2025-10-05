part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthSignUpWithEmail extends AuthEvent {
  final SignUpWithEmailParams params;
  AuthSignUpWithEmail(this.params);
}

class AuthCheck extends AuthEvent {}
