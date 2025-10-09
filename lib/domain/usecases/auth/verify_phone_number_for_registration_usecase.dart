import 'package:dartz/dartz.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/usecase/usecase.dart';
import 'package:foody_licious_admin_app/domain/repositories/auth_repository.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_up_with_phone_usecase.dart';

class VerifyPhoneNumberForRegistrationUseCase
    implements UseCase<Unit, SignUpWithPhoneParams> {
  final AuthRepository repository;
  VerifyPhoneNumberForRegistrationUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(SignUpWithPhoneParams params) async {
    return await repository.verifyPhoneNumberForRegistration(params);
  }
}
