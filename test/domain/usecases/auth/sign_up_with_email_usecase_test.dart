import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/domain/repositories/auth_repository.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_up_with_email_usecase.dart';
import 'package:mocktail/mocktail.dart';
import '../../../fixtures/constant_objects.dart';

class MockRepository extends Mock implements AuthRepository {}

void main() {
  late MockRepository mockRepository;
  late SignUpWithEmailUseCase usecase;

  setUp(() {
    mockRepository = MockRepository();
    usecase = SignUpWithEmailUseCase(mockRepository);
  });

  test(
      'Should get User for repository when mockRepository returns data successfully',
      () async {
    /// Arrange
    when(() => mockRepository.signUpWithEmail(tSignUpWithEmailParams))
        .thenAnswer((_) async => Right(tRestaurantModel));

    /// Act
    final result = await usecase(tSignUpWithEmailParams);

    /// Assert
    expect(result, Right(tRestaurantModel));
    verify(() => mockRepository.signUpWithEmail(tSignUpWithEmailParams));
    verifyNoMoreInteractions(mockRepository);
  });

  test(
      'Should get failure for repository',
      () async {
    final failure = NetworkFailure();

    /// Arrange
    when(() => mockRepository.signUpWithEmail(tSignUpWithEmailParams))
        .thenAnswer((_) async => Left(failure));

    /// Act
    final result = await usecase(tSignUpWithEmailParams);

    /// Assert
    expect(result, Left(failure));
    verify(() => mockRepository.signUpWithEmail(tSignUpWithEmailParams));
    verifyNoMoreInteractions(mockRepository);
  });
}
