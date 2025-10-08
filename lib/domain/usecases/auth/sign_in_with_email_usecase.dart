import 'package:dartz/dartz.dart';
import 'package:foody_licious_admin_app/core/usecase/usecase.dart';
import 'package:foody_licious_admin_app/domain/entities/restaurant/restaurant.dart';
import '../../../../../core/error/failures.dart';
import '../../repositories/auth_repository.dart';

class SignInWithEmailUseCase implements UseCase<Restaurant, SignInWithEmailParams> {
  final AuthRepository repository;
  SignInWithEmailUseCase(this.repository);

  @override
  Future<Either<Failure, Restaurant>> call(SignInWithEmailParams params) async {
    return await repository.signInWithEmail(params);
  }
}

class SignInWithEmailParams {
  final String email;
  final String password;
  final String authProvider;
  const SignInWithEmailParams({
    required this.email,
    required this.password,
    required this.authProvider,
  });
}
