import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/domain/usecases/order/get_all_order_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/order/update_order_status_usecase.dart';
import 'package:foody_licious_admin_app/presentation/bloc/order/order_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/constant_objects.dart';

class MockGetAllOrderUseCase extends Mock implements GetAllOrderUseCase {}

class MockUpdateOrderUseCase extends Mock implements UpdateOrderUseCase {}

void main() {
  late OrderBloc orderBloc;
  late MockGetAllOrderUseCase mockGetAllOrderUseCase;
  late MockUpdateOrderUseCase mockUpdateOrderUseCase;

  setUp(() {
    mockGetAllOrderUseCase = MockGetAllOrderUseCase();
    mockUpdateOrderUseCase = MockUpdateOrderUseCase();
    orderBloc = OrderBloc(mockGetAllOrderUseCase, mockUpdateOrderUseCase);
  });

  setUpAll(() {
    registerFallbackValue(tGetAllOrdersParams);
    registerFallbackValue(tUpdateOrderStatusParams);
  });

  test('initial state should be OrderInitial', () {
    expect(orderBloc.state, OrderInitial());
  });

  /// GetAllOrdersByStatus
  blocTest<OrderBloc, OrderState>(
    'emits [GetAllOrdersByStatusLoading, GetAllOrdersByStatusSuccess] when GetAllOrdersByStatus is added.',
    build: () {
      when(
        () => mockGetAllOrderUseCase(tGetAllOrdersParams),
      ).thenAnswer((_) async => Right(tOrdersResponseModel.orders));
      return orderBloc;
    },
    act: (bloc) => bloc.add(GetAllOrdersByStatus(tGetAllOrdersParams)),
    expect:
        () => [
          GetAllOrdersByStatusLoading(),
          GetAllOrdersByStatusSuccess(tOrdersResponseModel.orders),
        ],
  );

  blocTest<OrderBloc, OrderState>(
    'emits [GetAllOrdersByStatusLoading, GetAllOrdersByStatusFailed] when GetAllOrdersByStatus is added',
    build: () {
      when(
        () => mockGetAllOrderUseCase(tGetAllOrdersParams),
      ).thenAnswer((_) async => Left(CredentialFailure()));
      return orderBloc;
    },
    act: (bloc) => bloc.add(GetAllOrdersByStatus(tGetAllOrdersParams)),
    expect:
        () => [
          GetAllOrdersByStatusLoading(),
          GetAllOrdersByStatusFailed(CredentialFailure()),
        ],
  );

  blocTest<OrderBloc, OrderState>(
    'emits [GetAllOrdersByStatusLoading, GetAllOrdersByStatusFailed] when GetAllOrdersByStatus is added',
    build: () {
      when(
        () => mockGetAllOrderUseCase(tGetAllOrdersParams),
      ).thenAnswer((_) async => Left(RestaurantNotExistsFailure()));
      return orderBloc;
    },
    act: (bloc) => bloc.add(GetAllOrdersByStatus(tGetAllOrdersParams)),
    expect:
        () => [
          GetAllOrdersByStatusLoading(),
          GetAllOrdersByStatusFailed(RestaurantNotExistsFailure()),
        ],
  );

  blocTest<OrderBloc, OrderState>(
    'emits [GetAllOrdersByStatusLoading, GetAllOrdersByStatusFailed] when GetAllOrdersByStatus is added',
    build: () {
      when(
        () => mockGetAllOrderUseCase(tGetAllOrdersParams),
      ).thenAnswer((_) async => Left(RestaurantNotExistsFailure()));
      return orderBloc;
    },
    act: (bloc) => bloc.add(GetAllOrdersByStatus(tGetAllOrdersParams)),
    expect:
        () => [
          GetAllOrdersByStatusLoading(),
          GetAllOrdersByStatusFailed(RestaurantNotExistsFailure()),
        ],
  );

  blocTest<OrderBloc, OrderState>(
    'emits [GetAllOrdersByStatusLoading, GetAllOrdersByStatusFailed] when GetAllOrdersByStatus is added',
    build: () {
      when(
        () => mockGetAllOrderUseCase(tGetAllOrdersParams),
      ).thenAnswer((_) async => Left(ServerFailure()));
      return orderBloc;
    },
    act: (bloc) => bloc.add(GetAllOrdersByStatus(tGetAllOrdersParams)),
    expect:
        () => [
          GetAllOrdersByStatusLoading(),
          GetAllOrdersByStatusFailed(ServerFailure()),
        ],
  );

  blocTest<OrderBloc, OrderState>(
    'emits [GetAllOrdersByStatusLoading, GetAllOrdersByStatusFailed] when GetAllOrdersByStatus is added',
    build: () {
      when(
        () => mockGetAllOrderUseCase(tGetAllOrdersParams),
      ).thenAnswer((_) async => Left(ExceptionFailure('Error')));
      return orderBloc;
    },
    act: (bloc) => bloc.add(GetAllOrdersByStatus(tGetAllOrdersParams)),
    expect:
        () => [
          GetAllOrdersByStatusLoading(),
          GetAllOrdersByStatusFailed(ExceptionFailure('Error')),
        ],
  );

  ///updateOrderStatus
  blocTest<OrderBloc, OrderState>(
    'emits [UpdateOrderStatusLoading, UpdateOrderStatusSuccess] when UpdateOrderStatus is added.',
    build: () {
      when(
        () => mockUpdateOrderUseCase(tUpdateOrderStatusParams),
      ).thenAnswer((_) async => Right(tOrderResponseModel.orderResponseModel));
      return orderBloc;
    },
    act: (bloc) => bloc.add(UpdateOrderStatus(tUpdateOrderStatusParams)),
    expect:
        () => [
          UpdateOrderStatusLoading(),
          UpdateOrderStatusSuccess(tOrderResponseModel.orderResponseModel),
        ],
  );

  blocTest<OrderBloc, OrderState>(
    'emits [UpdateOrderStatusLoading, UpdateOrderStatusFailed] when UpdateOrderStatus is added.',
    build: () {
      when(
        () => mockUpdateOrderUseCase(tUpdateOrderStatusParams),
      ).thenAnswer((_) async => Left(CredentialFailure()));
      return orderBloc;
    },
    act: (bloc) => bloc.add(UpdateOrderStatus(tUpdateOrderStatusParams)),
    expect:
        () => [
          UpdateOrderStatusLoading(),
          UpdateOrderStatusFailed(CredentialFailure()),
        ],
  );


    blocTest<OrderBloc, OrderState>(
    'emits [UpdateOrderStatusLoading, UpdateOrderStatusFailed] when UpdateOrderStatus is added.',
    build: () {
      when(
        () => mockUpdateOrderUseCase(tUpdateOrderStatusParams),
      ).thenAnswer((_) async => Left(UnauthorizedRequestFailure()));
      return orderBloc;
    },
    act: (bloc) => bloc.add(UpdateOrderStatus(tUpdateOrderStatusParams)),
    expect:
        () => [
          UpdateOrderStatusLoading(),
          UpdateOrderStatusFailed(UnauthorizedRequestFailure()),
        ],
  );


    blocTest<OrderBloc, OrderState>(
    'emits [UpdateOrderStatusLoading, UpdateOrderStatusFailed] when UpdateOrderStatus is added.',
    build: () {
      when(
        () => mockUpdateOrderUseCase(tUpdateOrderStatusParams),
      ).thenAnswer((_) async => Left(OrderNotExistsFailure()));
      return orderBloc;
    },
    act: (bloc) => bloc.add(UpdateOrderStatus(tUpdateOrderStatusParams)),
    expect:
        () => [
          UpdateOrderStatusLoading(),
          UpdateOrderStatusFailed(OrderNotExistsFailure()),
        ],
  );


    blocTest<OrderBloc, OrderState>(
    'emits [UpdateOrderStatusLoading, UpdateOrderStatusFailed] when UpdateOrderStatus is added.',
    build: () {
      when(
        () => mockUpdateOrderUseCase(tUpdateOrderStatusParams),
      ).thenAnswer((_) async => Left(ServerFailure()));
      return orderBloc;
    },
    act: (bloc) => bloc.add(UpdateOrderStatus(tUpdateOrderStatusParams)),
    expect:
        () => [
          UpdateOrderStatusLoading(),
          UpdateOrderStatusFailed(ServerFailure()),
        ],
  );
}
