import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/domain/usecases/order/update_order_status_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:foody_licious_admin_app/domain/repositories/order_repository.dart';

import '../../../fixtures/constant_objects.dart';

class MockOrderRepository extends Mock implements OrderRepository {}

void main() {
  late MockOrderRepository mockRepository;
  late UpdateOrderUseCase usecase;

  setUp(() {
    mockRepository = MockOrderRepository();
    usecase = UpdateOrderUseCase(mockRepository);
  });

  test(
    'Should update order when order repository updates order successfully.',
    () async {
      /// Arrange
      when(
        () => mockRepository.updateOrderStatus(tUpdateOrderStatusParams),
      ).thenAnswer((_) async => Right(tOrderResponseModel.orderResponseModel));

      /// Act
      final result = await usecase(tUpdateOrderStatusParams);

      /// Assert
      expect(result, Right(tOrderResponseModel.orderResponseModel));
      verify(
        () => mockRepository.updateOrderStatus(tUpdateOrderStatusParams),
      ).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test('Should return a failure from this repository.',
   () async {
    final failure = NetworkFailure();

    /// Arrange
    when(
      () => mockRepository.updateOrderStatus(tUpdateOrderStatusParams),
    ).thenAnswer((_) async => Left(failure));

    /// Act
    final result = await usecase(tUpdateOrderStatusParams);

    /// Assert
    expect(result, Left(failure));
    verify(
      () => mockRepository.updateOrderStatus(tUpdateOrderStatusParams),
    ).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
