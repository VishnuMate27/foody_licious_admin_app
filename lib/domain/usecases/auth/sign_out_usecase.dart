import 'package:dartz/dartz.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/usecase/usecase.dart';
import 'package:foody_licious_admin_app/domain/repositories/auth_repository.dart';

class SignOutUseCase implements UseCase<Unit, NoParams> {
  final AuthRepository repository;
  SignOutUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(void params) async {
    return await repository.signOut();
  }
}
