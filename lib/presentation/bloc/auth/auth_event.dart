part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthSignInWithEmail extends AuthEvent {
  final SignInWithEmailParams params;
  AuthSignInWithEmail(this.params);
}

class AuthSignInWithGoogle extends AuthEvent {}

class AuthSignInWithFacebook extends AuthEvent {}

class AuthSignUpWithEmail extends AuthEvent {
  final SignUpWithEmailParams params;
  AuthSignUpWithEmail(this.params);
}

class AuthSignUpWithGoogle extends AuthEvent {}

class AuthSignUpWithFacebook extends AuthEvent {}

class AuthCheck extends AuthEvent {}
