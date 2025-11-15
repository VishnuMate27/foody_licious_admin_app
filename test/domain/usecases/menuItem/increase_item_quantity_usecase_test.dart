import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/domain/repositories/menu_item_repository.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/increase_item_quantity_usecase.dart';
import 'package:mocktail/mocktail.dart';
import '../../../fixtures/constant_objects.dart';

class MockRepository extends Mock implements MenuItemRepository {}

void main() {
  late IncreaseItemQuantityUseCase usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = IncreaseItemQuantityUseCase(mockRepository);
  });

  test(
    'Should add item in menu repository when Restaurant Repository return data successfully',
    () async {
      /// Arrange
      when(
        () => mockRepository.increaseItemQuantity(
          tIncreaseItemQuantityParams.itemId,
        ),
      ).thenAnswer((_) async => Right(tMenuItemModel));

      /// Act
      final result = await usecase(tIncreaseItemQuantityParams);

      /// Assert
      expect(result, Right(tMenuItemModel));
      verify(
        () => mockRepository.increaseItemQuantity(
          tIncreaseItemQuantityParams.itemId,
        ),
      );
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test('Should get failure from repository', () async {
    final failure = NetworkFailure();

    /// Arrange
    when(
      () => mockRepository.increaseItemQuantity(
        tIncreaseItemQuantityParams.itemId,
      ),
    ).thenAnswer((_) async => Left(failure));

    /// Act
    final result = await usecase(tIncreaseItemQuantityParams);

    /// Assert
    expect(result, Left(failure));
    verify(
      () => mockRepository.increaseItemQuantity(
        tIncreaseItemQuantityParams.itemId,
      ),
    ).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
