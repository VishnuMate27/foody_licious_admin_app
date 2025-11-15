import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/domain/repositories/menu_item_repository.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/delete_menu_item_usecase.dart';
import 'package:mocktail/mocktail.dart';
import '../../../fixtures/constant_objects.dart';

class MockRepository extends Mock implements MenuItemRepository {}

void main() {
  late DeleteMenuItemUseCase usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = DeleteMenuItemUseCase(mockRepository);
  });

  test(
    'Should add item in menu repository when Restaurant Repository return data successfully',
    () async {
      /// Arrange
      when(
        () => mockRepository.deleteItemInMenu(tDeleteMenuItemsParams),
      ).thenAnswer((_) async => Right(unit));

      /// Act
      final result = await usecase(tDeleteMenuItemsParams);

      /// Assert
      expect(result, Right(unit));
      verify(() => mockRepository.deleteItemInMenu(tDeleteMenuItemsParams));
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test('should return a Failure from the repository', () async {
    /// Arrange
    final failure = NetworkFailure();
    when(
      () => mockRepository.deleteItemInMenu(tDeleteMenuItemsParams),
    ).thenAnswer((_) async => Left(failure));

    /// Act
    final result = await usecase(tDeleteMenuItemsParams);

    /// Assert
    expect(result, Left(failure));
    verify(() => mockRepository.deleteItemInMenu(tDeleteMenuItemsParams));
    verifyNoMoreInteractions(mockRepository);
  });
}
