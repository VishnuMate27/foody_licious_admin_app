import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/usecase/usecase.dart';
import 'package:foody_licious_admin_app/domain/repositories/auth_repository.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_in_with_google_usecase.dart';
import 'package:mocktail/mocktail.dart';
import '../../../fixtures/constant_objects.dart';

class MockRepository extends Mock implements AuthRepository {}

void main() {
  late MockRepository mockRepository;
  late SignInWithGoogleUseCase usecase;

  setUp(() {
    mockRepository = MockRepository();
    usecase = SignInWithGoogleUseCase(mockRepository);
  });

  test(
    'Should get User when signInWithGoogle returns data successfully ',
    () async{
      /// Arrange
      when(() => mockRepository.signInWithGoogle())
          .thenAnswer((_) async => Right(tRestaurantModel));

      /// Act
      final result = await usecase(NoParams());

      /// Assert
      expect(result, Right(tRestaurantModel));
      verify(() => mockRepository.signInWithGoogle()).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test(
    'Should get failure from Repository',
    () async{
      final failure = NetworkFailure();

      /// Arrange
      when(() => mockRepository.signInWithGoogle())
          .thenAnswer((_) async => Left(failure));

      /// Act
      final result = await usecase(NoParams());

      /// Assert
      expect(result, Left(failure));
      verify(() => mockRepository.signInWithGoogle()).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
