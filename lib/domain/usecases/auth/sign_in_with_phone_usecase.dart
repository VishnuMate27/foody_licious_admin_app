import 'package:dartz/dartz.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/usecase/usecase.dart';
import 'package:foody_licious_admin_app/domain/entities/restaurant/restaurant.dart';
import 'package:foody_licious_admin_app/domain/repositories/auth_repository.dart';


class SignInWithPhoneUseCase implements UseCase<Restaurant, SignInWithPhoneParams> {
  final AuthRepository repository;
  SignInWithPhoneUseCase(this.repository);

  @override
  Future<Either<Failure, Restaurant>> call(SignInWithPhoneParams params) async {
    return await repository.signInWithPhone(params);
  }
}

class SignInWithPhoneParams {
  final String? phone;
  final String? code;
  final String authProvider;
  const SignInWithPhoneParams(
      {this.phone, this.code, required this.authProvider});
}
