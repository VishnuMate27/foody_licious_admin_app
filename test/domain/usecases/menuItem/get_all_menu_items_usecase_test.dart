import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/domain/repositories/menu_item_repository.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/get_all_menu_items_usecase.dart';
import 'package:mocktail/mocktail.dart';
import '../../../fixtures/constant_objects.dart';

class MockRepository extends Mock implements MenuItemRepository {}

void main() {
  late GetAllMenuItemsUseCase usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = GetAllMenuItemsUseCase(mockRepository);
  });

  test(
    'Should add item in menu  repository when Restaurant Repository return data successfully',
    () async {
      /// Arrange
      when(
        () => mockRepository.getAllMenuItem(tGetAllMenuItemsParams),
      ).thenAnswer((_) async => Right(tMenuItemsResponseModel.menuItems));

      /// Act
      final result = await usecase(tGetAllMenuItemsParams);

      /// Assert
      expect(result, Right(tMenuItemsResponseModel.menuItems));
      verify(() => mockRepository.getAllMenuItem(tGetAllMenuItemsParams));
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test('should return a Failure from the repository', () async {
    /// Arrange
    final failure = NetworkFailure();
    when(
      () => mockRepository.getAllMenuItem(tGetAllMenuItemsParams),
    ).thenAnswer((_) async => Left(failure));

    /// Act
    final result = await usecase(tGetAllMenuItemsParams);

    /// Assert
    expect(result, Left(failure));
    verify(() => mockRepository.getAllMenuItem(tGetAllMenuItemsParams));
    verifyNoMoreInteractions(mockRepository);
  });
}
