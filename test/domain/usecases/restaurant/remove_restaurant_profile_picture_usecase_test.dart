import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/usecase/usecase.dart';
import 'package:foody_licious_admin_app/domain/repositories/restaurant_repository.dart';
import 'package:foody_licious_admin_app/domain/usecases/restaurant/remove_restaurant_profile_picture_usecase.dart';
import 'package:mocktail/mocktail.dart';
import '../../../fixtures/constant_objects.dart';

class MockRepository extends Mock implements RestaurantRepository {}
void main() {
  late RemoveRestaurantProfilePictureUseCase usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = RemoveRestaurantProfilePictureUseCase(mockRepository);
  });

    test(
    'Should get Restaurant from the repository when Restaurant Repository return data successfully',
        () async {
      /// Arrange
      when(() => mockRepository.removeRestaurantProfilePicture())
          .thenAnswer((_) async => const Right(tRestaurantModel));

      /// Act
      final result = await usecase(NoParams());

      /// Assert
      expect(result, const Right(tRestaurantModel));
      verify(() => mockRepository.removeRestaurantProfilePicture());
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test('should return a Failure from the repository', () async {
    /// Arrange
    final failure = NetworkFailure();
    when(() => mockRepository.removeRestaurantProfilePicture())
        .thenAnswer((_) async => Left(failure));

    /// Act
    final result = await usecase(NoParams());

    /// Assert
    expect(result, Left(failure));
    verify(() => mockRepository.removeRestaurantProfilePicture());
    verifyNoMoreInteractions(mockRepository);
  });
}
