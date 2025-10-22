import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/domain/repositories/restaurant_repository.dart';
import 'package:foody_licious_admin_app/domain/usecases/restaurant/update_restaurant_usecase.dart';
import 'package:mocktail/mocktail.dart';
import '../../../fixtures/constant_objects.dart';

class MockRepository extends Mock implements RestaurantRepository {}
void main() {
  late UpdateRestaurantUseCase usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = UpdateRestaurantUseCase(mockRepository);
  });

    test(
    'Should get Restaurant from the repository when Restaurant Repository return data successfully',
        () async {
      /// Arrange
      when(() => mockRepository.updateRestaurant(tUpdateRestaurantParams))
          .thenAnswer((_) async => const Right(tRestaurantModel));

      /// Act
      final result = await usecase(tUpdateRestaurantParams);

      /// Assert
      expect(result, const Right(tRestaurantModel));
      verify(() => mockRepository.updateRestaurant(tUpdateRestaurantParams));
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test('should return a Failure from the repository', () async {
    /// Arrange
    final failure = NetworkFailure();
    when(() => mockRepository.updateRestaurant(tUpdateRestaurantParams))
        .thenAnswer((_) async => Left(failure));

    /// Act
    final result = await usecase(tUpdateRestaurantParams);

    /// Assert
    expect(result, Left(failure));
    verify(() => mockRepository.updateRestaurant(tUpdateRestaurantParams));
    verifyNoMoreInteractions(mockRepository);
  });
}
