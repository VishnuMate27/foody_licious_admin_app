import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/usecase/usecase.dart';
import 'package:foody_licious_admin_app/domain/repositories/restaurant_repository.dart';
import 'package:foody_licious_admin_app/domain/usecases/restaurant/delete_restaurant_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock implements RestaurantRepository {}

void main() {
  late MockRepository mockRepository;
  late DeleteRestaurantUseCase usecase;

  setUp(() {
    mockRepository = MockRepository();
    usecase = DeleteRestaurantUseCase(mockRepository);
  });

  test(
    'Should get Unit from repository when mockRepository returns data successfully.',
    () async {
      /// Arrange
      when(() => mockRepository.deleteRestaurant())
          .thenAnswer((_) async => Right(unit));

      /// Act
      final result = await usecase(NoParams());

      /// Assert
      expect(result, Right(unit));
      verify(() => mockRepository.deleteRestaurant()).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test(
    'Should get failure from repository',
    () async {
      final failure = NetworkFailure();

      /// Arrange
      when(() => mockRepository.deleteRestaurant())
          .thenAnswer((_) async => Left(failure));

      /// Act
      final result = await usecase(NoParams());

      /// Assert
      expect(result, Left(failure));
      verify(() => mockRepository.deleteRestaurant()).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
