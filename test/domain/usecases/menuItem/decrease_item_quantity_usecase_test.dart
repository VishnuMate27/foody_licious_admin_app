import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/domain/repositories/menu_item_repository.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/decrease_item_quantity_usecase.dart';
import 'package:mocktail/mocktail.dart';
import '../../../fixtures/constant_objects.dart';

class MockRepository extends Mock implements MenuItemRepository {}

void main() {
  late DecreaseItemQuantityUseCase usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = DecreaseItemQuantityUseCase(mockRepository);
  });

  test(
    'Should add item in menu repository when Restaurant Repository return data successfully',
    () async {
      /// Arrange
      when(
        () => mockRepository.decreaseItemQuantity(
          tDecreaseItemQuantityParams.itemId,
        ),
      ).thenAnswer((_) async => Right(tMenuItemModel));

      /// Act
      final result = await usecase(tDecreaseItemQuantityParams);

      /// Assert
      expect(result, Right(tMenuItemModel));
      verify(
        () => mockRepository.decreaseItemQuantity(
          tDecreaseItemQuantityParams.itemId,
        ),
      );
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test('Should get failure from repository', () async {
    final failure = NetworkFailure();

    /// Arrange
    when(
      () => mockRepository.decreaseItemQuantity(
        tDecreaseItemQuantityParams.itemId,
      ),
    ).thenAnswer((_) async => Left(failure));

    /// Act
    final result = await usecase(tDecreaseItemQuantityParams);

    /// Assert
    expect(result, Left(failure));
    verify(
      () => mockRepository.decreaseItemQuantity(
        tDecreaseItemQuantityParams.itemId,
      ),
    ).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
