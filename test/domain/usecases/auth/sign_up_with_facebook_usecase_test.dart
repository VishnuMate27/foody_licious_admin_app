import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/usecase/usecase.dart';
import 'package:foody_licious_admin_app/domain/repositories/auth_repository.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_up_with_facebook_usecase.dart';
import 'package:mocktail/mocktail.dart';
import '../../../fixtures/constant_objects.dart';

class MockRepository extends Mock implements AuthRepository {}

void main() {
  late MockRepository mockRepository;
  late SignUpWithFacebookUseCase usecase;

  setUp(() {
    mockRepository = MockRepository();
    usecase = SignUpWithFacebookUseCase(mockRepository);
  });

  test(
    'Should get User from repository when mockRepository returns data successfully',
    () async {
      /// Arrange
      when(() => mockRepository.signUpWithFacebook())
          .thenAnswer((_) async => Right(tRestaurantModel));

      /// Act
      final result = await usecase(NoParams());

      /// Assert
      expect(result, Right(tRestaurantModel));
      verify(() => mockRepository.signUpWithFacebook()).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test(
    'Should get failure from repository',
    () async {
      final failure = NetworkFailure();

      /// Arrange
      when(() => mockRepository.signUpWithFacebook())
          .thenAnswer((_) async => Left(failure));

      /// Act
      final result = await usecase(NoParams());

      /// Assert
      expect(result, Left(failure));
      verify(() => mockRepository.signUpWithFacebook()).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
