import 'package:dartz/dartz.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/domain/entities/restaurant/restaurant.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_in_with_email_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_up_with_email_usecase.dart';

abstract class AuthRepository {
  Future<Either<Failure, Restaurant>> signInWithEmail(SignInWithEmailParams params);
  Future<Either<Failure, Restaurant>> signInWithGoogle();
  Future<Either<Failure, Restaurant>> signInWithFacebook();
  Future<Either<Failure, Restaurant>> signUpWithEmail(
    SignUpWithEmailParams params,
  );
  Future<Either<Failure, Restaurant>> signUpWithGoogle();
  Future<Either<Failure, Restaurant>> signUpWithFacebook();
}
