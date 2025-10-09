import 'package:dartz/dartz.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/usecase/usecase.dart';
import 'package:foody_licious_admin_app/domain/repositories/auth_repository.dart';

class SendVerificationEmailUseCase implements UseCase<Unit, void> {
  final AuthRepository repository;
  SendVerificationEmailUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(void params) async {
    return await repository.sendVerificationEmail();
  }
}
