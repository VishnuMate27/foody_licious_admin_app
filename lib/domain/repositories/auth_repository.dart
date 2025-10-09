import 'package:dartz/dartz.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/domain/entities/restaurant/restaurant.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/send_password_reset_email_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_in_with_email_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_in_with_phone_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_up_with_email_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_up_with_phone_usecase.dart';

abstract class AuthRepository {
  Future<Either<Failure, Restaurant>> signInWithEmail(SignInWithEmailParams params);
  Future<Either<Failure, Unit>> verifyPhoneNumberForLogin(
      SignInWithPhoneParams params);
  Future<Either<Failure, Restaurant>> signInWithPhone(SignInWithPhoneParams params);
  Future<Either<Failure, Restaurant>> signInWithGoogle();
  Future<Either<Failure, Restaurant>> signInWithFacebook();
  Future<Either<Failure, Unit>> sendPasswordResetEmail(
      SendPasswordResetEmailParams params);
  Future<Either<Failure, Restaurant>> signUpWithEmail(SignUpWithEmailParams params);
  Future<Either<Failure, Unit>> sendVerificationEmail();
  Future<Either<Failure, Unit>> waitForEmailVerification();
  Future<Either<Failure, Unit>> verifyPhoneNumberForRegistration(
      SignUpWithPhoneParams params);
  Future<Either<Failure, Restaurant>> signUpWithPhone(SignUpWithPhoneParams params);
  Future<Either<Failure, Restaurant>> signUpWithGoogle();
  Future<Either<Failure, Restaurant>> signUpWithFacebook();
  Future<Either<Failure, Unit>> signOut();
}
