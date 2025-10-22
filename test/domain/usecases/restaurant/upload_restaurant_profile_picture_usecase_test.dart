import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/domain/repositories/restaurant_repository.dart';
import 'package:foody_licious_admin_app/domain/usecases/restaurant/upload_restaurant_profile_picture_usecase.dart';
import 'package:mocktail/mocktail.dart';
import '../../../fixtures/constant_objects.dart';

class MockRepository extends Mock implements RestaurantRepository {}

void main() {
  late UploadRestaurantProfilePictureUseCase usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = UploadRestaurantProfilePictureUseCase(mockRepository);
  });

  test(
    'Should get Restaurant from the repository when Restaurant Repository return data successfully',
    () async {
      /// Arrange
      when(
        () => mockRepository.uploadRestaurantProfilePicture(
          tUploadRestaurantProfilePictureParams,
        ),
      ).thenAnswer((_) async => const Right(tRestaurantModel));

      /// Act
      final result = await usecase(tUploadRestaurantProfilePictureParams);

      /// Assert
      expect(result, const Right(tRestaurantModel));
      verify(
        () => mockRepository.uploadRestaurantProfilePicture(
          tUploadRestaurantProfilePictureParams,
        ),
      );
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test('should return a Failure from the repository', () async {
    /// Arrange
    final failure = NetworkFailure();
    when(
      () => mockRepository.uploadRestaurantProfilePicture(
        tUploadRestaurantProfilePictureParams,
      ),
    ).thenAnswer((_) async => Left(failure));

    /// Act
    final result = await usecase(tUploadRestaurantProfilePictureParams);

    /// Assert
    expect(result, Left(failure));
    verify(
      () => mockRepository.uploadRestaurantProfilePicture(
        tUploadRestaurantProfilePictureParams,
      ),
    );
    verifyNoMoreInteractions(mockRepository);
  });
}
