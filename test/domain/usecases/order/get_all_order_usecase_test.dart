import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/domain/repositories/order_repository.dart';
import 'package:foody_licious_admin_app/domain/usecases/order/get_all_order_usecase.dart';
import 'package:mocktail/mocktail.dart';
import '../../../fixtures/constant_objects.dart';

class MockOrderRepository extends Mock implements OrderRepository {}

void main() {
  late GetAllOrderUseCase usecase;
  late MockOrderRepository mockRepository;

  setUp(() {
    mockRepository = MockOrderRepository();
    usecase = GetAllOrderUseCase(mockRepository);
  });

  test(
    'Should get all orders when order repository return data successfully',
    () async {
      /// Arrange
      when(
        () => mockRepository.getAllOrders(tGetAllOrdersParams),
      ).thenAnswer((_) async => Right(tOrdersResponseModel.orders));

      /// Act
      final result = await usecase(tGetAllOrdersParams);

      /// Assert
      expect(result, Right(tOrdersResponseModel.orders));
      verify(() => mockRepository.getAllOrders(tGetAllOrdersParams)).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

    test(
    'should return a Failure from the repository',
    () async {
      /// Arrange
      final failure = NetworkFailure();
      when(
        () => mockRepository.getAllOrders(tGetAllOrdersParams),
      ).thenAnswer((_) async => Left(failure));

      /// Act
      final result = await usecase(tGetAllOrdersParams);

      /// Assert
      expect(result, Left(failure));
      verify(() => mockRepository.getAllOrders(tGetAllOrdersParams)).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
