import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/network/network_info.dart';
import 'package:foody_licious_admin_app/data/data_sources/local/restaurant_local_data_source.dart';
import 'package:foody_licious_admin_app/data/data_sources/remote/order_remote_data_source.dart';
import 'package:foody_licious_admin_app/data/repositories/order_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/constant_objects.dart';

class MockOrderRemoteDataSource extends Mock implements OrderRemoteDataSource {}

class MockRestaurantLocalDataSource extends Mock
    implements RestaurantLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late OrderRepositoryImpl repository;
  late MockOrderRemoteDataSource mockRemoteDataSource;
  late MockRestaurantLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockOrderRemoteDataSource();
    mockLocalDataSource = MockRestaurantLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = OrderRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      restaurantLocalDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  runTestsOnline(() {
    group('getAllOrders', () {
      test(
        'should return Right(OrderEntity) when remoteDataSource.getAllOrders succeeds',
        () async {
          // arrange
          when(
            () => mockLocalDataSource.getRestaurant(),
          ).thenAnswer((_) async => tRestaurantModel);
          tGetAllOrdersParams.restaurantId = tRestaurantModel.id;
          when(
            () => mockRemoteDataSource.getAllOrders(tGetAllOrdersParams),
          ).thenAnswer((_) async => tOrdersResponseModel);

          // act
          final result = await repository.getAllOrders(tGetAllOrdersParams);

          // assert
          verify(() => mockLocalDataSource.getRestaurant()).called(1);
          verify(
            () => mockRemoteDataSource.getAllOrders(tGetAllOrdersParams),
          ).called(1);
          expect(result, Right(tOrdersResponseModel.orders));
        },
      );

      test(
        'should return Left(failure) when remoteDataSource.getAllOrders throws CredentialFailure',
        () async {
          // arrange
          when(
            () => mockLocalDataSource.getRestaurant(),
          ).thenAnswer((_) async => tRestaurantModel);
          tGetAllOrdersParams.restaurantId = tRestaurantModel.id;
          when(
            () => mockRemoteDataSource.getAllOrders(tGetAllOrdersParams),
          ).thenThrow(CredentialFailure());

          // act
          final result = await repository.getAllOrders(tGetAllOrdersParams);

          // assert
          verify(() => mockLocalDataSource.getRestaurant()).called(1);
          verify(
            () => mockRemoteDataSource.getAllOrders(tGetAllOrdersParams),
          ).called(1);
          expect(result, Left(CredentialFailure()));
        },
      );

      test(
        'should return Left(failure) when remoteDataSource.getAllOrders throws RestaurantNotExistsFailure',
        () async {
          // arrange
          when(
            () => mockLocalDataSource.getRestaurant(),
          ).thenAnswer((_) async => tRestaurantModel);
          tGetAllOrdersParams.restaurantId = tRestaurantModel.id;
          when(
            () => mockRemoteDataSource.getAllOrders(tGetAllOrdersParams),
          ).thenThrow(RestaurantNotExistsFailure());

          // act
          final result = await repository.getAllOrders(tGetAllOrdersParams);

          // assert
          verify(() => mockLocalDataSource.getRestaurant()).called(1);
          verify(
            () => mockRemoteDataSource.getAllOrders(tGetAllOrdersParams),
          ).called(1);
          expect(result, Left(RestaurantNotExistsFailure()));
        },
      );

      test(
        'should return Left(failure) when remoteDataSource.getAllOrders throws ServerFailure',
        () async {
          // arrange
          when(
            () => mockLocalDataSource.getRestaurant(),
          ).thenAnswer((_) async => tRestaurantModel);
          tGetAllOrdersParams.restaurantId = tRestaurantModel.id;
          when(
            () => mockRemoteDataSource.getAllOrders(tGetAllOrdersParams),
          ).thenThrow(ServerFailure());

          // act
          final result = await repository.getAllOrders(tGetAllOrdersParams);

          // assert
          verify(() => mockLocalDataSource.getRestaurant()).called(1);
          verify(
            () => mockRemoteDataSource.getAllOrders(tGetAllOrdersParams),
          ).called(1);
          expect(result, Left(ServerFailure()));
        },
      );
    });

    group('updateOrderStatus', () {
      test(
        'should return Right(OrderEntity) when remoteDataSource.updateOrderStatus succeeds',
        () async {
          // arrange
          when(
            () => mockLocalDataSource.getRestaurant(),
          ).thenAnswer((_) async => tRestaurantModel);
          tUpdateOrderStatusParams.restaurantId = tRestaurantModel.id;
          when(
            () => mockRemoteDataSource.updateOrderStatus(
              tUpdateOrderStatusParams,
            ),
          ).thenAnswer((_) async => tOrderResponseModel);

          // act
          final result = await repository.updateOrderStatus(
            tUpdateOrderStatusParams,
          );

          // assert
          verify(() => mockLocalDataSource.getRestaurant()).called(1);
          verify(
            () => mockRemoteDataSource.updateOrderStatus(
              tUpdateOrderStatusParams,
            ),
          ).called(1);
          expect(result, Right(tOrderResponseModel.orderResponseModel));
        },
      );

      test(
        'should return Left(failure) when remoteDataSource.updateOrderStatus throws CredentialFailure',
        () async {
          // arrange
          when(
            () => mockLocalDataSource.getRestaurant(),
          ).thenAnswer((_) async => tRestaurantModel);
          tUpdateOrderStatusParams.restaurantId = tRestaurantModel.id;
          when(
            () => mockRemoteDataSource.updateOrderStatus(
              tUpdateOrderStatusParams,
            ),
          ).thenThrow(CredentialFailure());

          // act
          final result = await repository.updateOrderStatus(
            tUpdateOrderStatusParams,
          );

          // assert
          verify(() => mockLocalDataSource.getRestaurant()).called(1);
          verify(
            () => mockRemoteDataSource.updateOrderStatus(
              tUpdateOrderStatusParams,
            ),
          ).called(1);
          expect(result, Left(CredentialFailure()));
        },
      );

      test(
        'should return Left(failure) when remoteDataSource.updateOrderStatus throws UnauthorizedRequestFailure',
        () async {
          // arrange
          when(
            () => mockLocalDataSource.getRestaurant(),
          ).thenAnswer((_) async => tRestaurantModel);
          tUpdateOrderStatusParams.restaurantId = tRestaurantModel.id;
          when(
            () => mockRemoteDataSource.updateOrderStatus(
              tUpdateOrderStatusParams,
            ),
          ).thenThrow(UnauthorizedRequestFailure());

          // act
          final result = await repository.updateOrderStatus(
            tUpdateOrderStatusParams,
          );

          // assert
          verify(() => mockLocalDataSource.getRestaurant()).called(1);
          verify(
            () => mockRemoteDataSource.updateOrderStatus(
              tUpdateOrderStatusParams,
            ),
          ).called(1);
          expect(result, Left(UnauthorizedRequestFailure()));
        },
      );

      test(
        'should return Left(failure) when remoteDataSource.updateOrderStatus throws OrderNotExistsFailure',
        () async {
          // arrange
          when(
            () => mockLocalDataSource.getRestaurant(),
          ).thenAnswer((_) async => tRestaurantModel);
          tUpdateOrderStatusParams.restaurantId = tRestaurantModel.id;
          when(
            () => mockRemoteDataSource.updateOrderStatus(
              tUpdateOrderStatusParams,
            ),
          ).thenThrow(OrderNotExistsFailure());

          // act
          final result = await repository.updateOrderStatus(
            tUpdateOrderStatusParams,
          );

          // assert
          verify(() => mockLocalDataSource.getRestaurant()).called(1);
          verify(
            () => mockRemoteDataSource.updateOrderStatus(
              tUpdateOrderStatusParams,
            ),
          ).called(1);
          expect(result, Left(OrderNotExistsFailure()));
        },
      );

      test(
        'should return Left(failure) when remoteDataSource.updateOrderStatus throws ServerFailure',
        () async {
          // arrange
          when(
            () => mockLocalDataSource.getRestaurant(),
          ).thenAnswer((_) async => tRestaurantModel);
          tUpdateOrderStatusParams.restaurantId = tRestaurantModel.id;
          when(
            () => mockRemoteDataSource.updateOrderStatus(
              tUpdateOrderStatusParams,
            ),
          ).thenThrow(ServerFailure());

          // act
          final result = await repository.updateOrderStatus(
            tUpdateOrderStatusParams,
          );

          // assert
          verify(() => mockLocalDataSource.getRestaurant()).called(1);
          verify(
            () => mockRemoteDataSource.updateOrderStatus(
              tUpdateOrderStatusParams,
            ),
          ).called(1);
          expect(result, Left(ServerFailure()));
        },
      );
    });
  });
}
