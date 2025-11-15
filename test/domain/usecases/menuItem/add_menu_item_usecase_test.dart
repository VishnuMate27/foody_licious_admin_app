import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/domain/repositories/menu_item_repository.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/add_menu_item_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/constant_objects.dart';

class MockRepository extends Mock implements MenuItemRepository {}

void main() {
  late AddMenuItemUseCase usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = AddMenuItemUseCase(mockRepository);
  });

  test(
    'Should add item in menu  repository when Restaurant Repository return data successfully',
    () async {
      /// Arrange
      when(
        () => mockRepository.addItemInMenu(tAddMenuItemParams),
      ).thenAnswer((_) async => const Right(unit));

      /// Act
      final result = await usecase(tAddMenuItemParams);

      /// Assert
      expect(result, const Right(unit));
      verify(() => mockRepository.addItemInMenu(tAddMenuItemParams));
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test('should return a Failure from the repository', () async {
    /// Arrange
    final failure = NetworkFailure();
    when(() => mockRepository.addItemInMenu(tAddMenuItemParams))
        .thenAnswer((_) async => Left(failure));

    /// Act
    final result = await usecase(tAddMenuItemParams);

    /// Assert
    expect(result, Left(failure));
    verify(() => mockRepository.addItemInMenu(tAddMenuItemParams));
    verifyNoMoreInteractions(mockRepository);
  });
}
