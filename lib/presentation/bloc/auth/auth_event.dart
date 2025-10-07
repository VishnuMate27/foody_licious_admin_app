part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthSignUpWithEmail extends AuthEvent {
  final SignUpWithEmailParams params;
  AuthSignUpWithEmail(this.params);
}

class AuthSignUpWithGoogle extends AuthEvent {}

class AuthSignUpWithFacebook extends AuthEvent {}

class AuthCheck extends AuthEvent {}
