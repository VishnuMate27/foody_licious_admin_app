import 'package:dartz/dartz.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/usecase/usecase.dart';
import 'package:foody_licious_admin_app/domain/entities/restaurant/restaurant.dart';
import 'package:foody_licious_admin_app/domain/repositories/auth_repository.dart';

class SignUpWithEmailUseCase
    implements UseCase<Restaurant, SignUpWithEmailParams> {
  final AuthRepository repository;
  SignUpWithEmailUseCase(this.repository);

  @override
  Future<Either<Failure, Restaurant>> call(SignUpWithEmailParams params) async {
    return await repository.signUpWithEmail(params);
  }
}

class SignUpWithEmailParams {
  final String? ownerName;
  final String? email;
  final String? password;
  final String authProvider;
  const SignUpWithEmailParams({
    this.ownerName,
    this.email,
    this.password,
    required this.authProvider,
  });
}
