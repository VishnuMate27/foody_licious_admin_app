import 'package:dartz/dartz.dart';
import 'package:foody_licious_admin_app/core/usecase/usecase.dart';
import 'package:foody_licious_admin_app/domain/entities/restaurant/restaurant.dart';
import '../../../../../core/error/failures.dart';
import '../../repositories/auth_repository.dart';

class SignUpWithPhoneUseCase
    implements UseCase<Restaurant, SignUpWithPhoneParams> {
  final AuthRepository repository;
  SignUpWithPhoneUseCase(this.repository);

  @override
  Future<Either<Failure, Restaurant>> call(SignUpWithPhoneParams params) async {
    return await repository.signUpWithPhone(params);
  }
}

class SignUpWithPhoneParams {
  final String? ownerName;
  final String? phone;
  final String? code;
  final String authProvider;
  const SignUpWithPhoneParams({
    this.ownerName,
    this.phone,
    this.code,
    required this.authProvider,
  });
}
