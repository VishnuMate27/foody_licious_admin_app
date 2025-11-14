import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/network/network_info.dart';
import 'package:foody_licious_admin_app/data/data_sources/local/restaurant_local_data_source.dart';
import 'package:foody_licious_admin_app/data/data_sources/remote/menu_remote_data_source.dart';
import 'package:foody_licious_admin_app/data/repositories/menu_item_repository_impl.dart';
import 'package:foody_licious_admin_app/domain/entities/menuItem/menuItem.dart';
import 'package:mocktail/mocktail.dart';
import '../../fixtures/constant_objects.dart';

class MockRemoteDataSource extends Mock implements MenuItemsRemoteDataSource {}

class MockLocalDataSource extends Mock implements RestaurantLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MenuItemRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = MenuItemRepositoryImpl(
      menuItemsRemoteDataSource: mockRemoteDataSource,
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
    group('addItemInMenu', () {
      test(
        'should return Right(Unit) when remoteDataSource.addItemInMenu succeeds',
        () async {
          // arrange
          when(
            () => mockLocalDataSource.getRestaurant(),
          ).thenAnswer((_) async => tRestaurantModel);
          when(
            () => mockRemoteDataSource.addItemInMenu(tAddMenuItemParams),
          ).thenAnswer((_) async => unit);

          // act
          final result = await repository.addItemInMenu(tAddMenuItemParams);

          // assert
          verify(() => mockLocalDataSource.getRestaurant()).called(1);
          verify(
            () => mockRemoteDataSource.addItemInMenu(tAddMenuItemParams),
          ).called(1);
          expect(result, Right(unit));
        },
      );

      test(
        'should return Left(Failure) when remoteDataSource.addItemInMenu throws CredentialFailure',
        () async {
          // arrange
          when(
            () => mockLocalDataSource.getRestaurant(),
          ).thenAnswer((_) async => tRestaurantModel);
          when(
            () => mockRemoteDataSource.addItemInMenu(tAddMenuItemParams),
          ).thenThrow(CredentialFailure());

          // act
          final result = await repository.addItemInMenu(tAddMenuItemParams);

          // assert
          verify(() => mockLocalDataSource.getRestaurant()).called(1);
          verify(
            () => mockRemoteDataSource.addItemInMenu(tAddMenuItemParams),
          ).called(1);
          expect(result, Left(CredentialFailure()));
        },
      );

      test(
        'should return Left(Failure) when remoteDataSource.addItemInMenu throws RestaurantNotExistsFailure',
        () async {
          // arrange
          when(
            () => mockLocalDataSource.getRestaurant(),
          ).thenAnswer((_) async => tRestaurantModel);
          when(
            () => mockRemoteDataSource.addItemInMenu(tAddMenuItemParams),
          ).thenThrow(RestaurantNotExistsFailure());

          // act
          final result = await repository.addItemInMenu(tAddMenuItemParams);

          // assert
          verify(() => mockLocalDataSource.getRestaurant()).called(1);
          verify(
            () => mockRemoteDataSource.addItemInMenu(tAddMenuItemParams),
          ).called(1);
          expect(result, Left(RestaurantNotExistsFailure()));
        },
      );

      test(
        'should return Left(Failure) when remoteDataSource.addItemInMenu throws ItemAlreadyExistsFailure',
        () async {
          // arrange
          when(
            () => mockLocalDataSource.getRestaurant(),
          ).thenAnswer((_) async => tRestaurantModel);
          when(
            () => mockRemoteDataSource.addItemInMenu(tAddMenuItemParams),
          ).thenThrow(ItemAlreadyExistsFailure());

          // act
          final result = await repository.addItemInMenu(tAddMenuItemParams);

          // assert
          verify(() => mockLocalDataSource.getRestaurant()).called(1);
          verify(
            () => mockRemoteDataSource.addItemInMenu(tAddMenuItemParams),
          ).called(1);
          expect(result, Left(ItemAlreadyExistsFailure()));
        },
      );

      test(
        'should return Left(Failure) when remoteDataSource.addItemInMenu throws ServerFailure',
        () async {
          // arrange
          when(
            () => mockLocalDataSource.getRestaurant(),
          ).thenAnswer((_) async => tRestaurantModel);
          when(
            () => mockRemoteDataSource.addItemInMenu(tAddMenuItemParams),
          ).thenThrow(ServerFailure());

          // act
          final result = await repository.addItemInMenu(tAddMenuItemParams);

          // assert
          verify(() => mockLocalDataSource.getRestaurant()).called(1);
          verify(
            () => mockRemoteDataSource.addItemInMenu(tAddMenuItemParams),
          ).called(1);
          expect(result, Left(ServerFailure()));
        },
      );
    });

    group('updateItemInMenu', () {
      test(
        'should return Right(MenuItem) when remoteDataSource.updateItemInMenu succeeds',
        () async {
          // arrange
          when(
            () => mockLocalDataSource.getRestaurant(),
          ).thenAnswer((_) async => tRestaurantModel);
          when(
            () => mockRemoteDataSource.updateItemInMenu(tUpdateMenuItemParams),
          ).thenAnswer((_) async => tMenuItemResponseModel);

          // act
          final result = await repository.updateItemInMenu(
            tUpdateMenuItemParams,
          );

          // assert
          verify(() => mockLocalDataSource.getRestaurant()).called(1);
          verify(
            () => mockRemoteDataSource.updateItemInMenu(tUpdateMenuItemParams),
          ).called(1);
          expect(result, Right(tMenuItemResponseModel.menuItemResponseModel));
        },
      );

      test(
        'should return Left(Failure) when remoteDataSource.updateItemInMenu throws CredentialFailure',
        () async {
          // arrange
          when(
            () => mockLocalDataSource.getRestaurant(),
          ).thenAnswer((_) async => tRestaurantModel);
          when(
            () => mockRemoteDataSource.updateItemInMenu(tUpdateMenuItemParams),
          ).thenThrow(CredentialFailure());

          // act
          final result = await repository.updateItemInMenu(
            tUpdateMenuItemParams,
          );

          // assert
          verify(() => mockLocalDataSource.getRestaurant()).called(1);
          verify(
            () => mockRemoteDataSource.updateItemInMenu(tUpdateMenuItemParams),
          ).called(1);
          expect(result, Left(CredentialFailure()));
        },
      );

      test(
        'should return Left(Failure) when remoteDataSource.deleteItemInMenu throws ServerFailure',
        () async {
          // arrange
          when(
            () => mockLocalDataSource.getRestaurant(),
          ).thenAnswer((_) async => tRestaurantModel);
          when(
            () => mockRemoteDataSource.updateItemInMenu(tUpdateMenuItemParams),
          ).thenThrow(ServerFailure());

          // act
          final result = await repository.updateItemInMenu(
            tUpdateMenuItemParams,
          );

          // assert
          verify(
            () => mockRemoteDataSource.updateItemInMenu(tUpdateMenuItemParams),
          ).called(1);
          expect(result, Left(ServerFailure()));
        },
      );
    });

    group('deleteItemInMenu', () {
      test(
        'should return Right(Unit) when remoteDataSource.deleteItemInMenu succeeds',
        () async {
          // arrange
          when(
            () => mockRemoteDataSource.deleteItemInMenu(tDeleteMenuItemsParams),
          ).thenAnswer((_) async => unit);

          // act
          final result = await repository.deleteItemInMenu(
            tDeleteMenuItemsParams,
          );

          // assert
          verify(
            () => mockRemoteDataSource.deleteItemInMenu(tDeleteMenuItemsParams),
          ).called(1);
          expect(result, Right(unit));
        },
      );

      test(
        'should return Left(Failure) when remoteDataSource.deleteItemInMenu throws CredentialFailure',
        () async {
          // arrange
          when(
            () => mockLocalDataSource.getRestaurant(),
          ).thenAnswer((_) async => tRestaurantModel);
          when(
            () => mockRemoteDataSource.addItemInMenu(tAddMenuItemParams),
          ).thenThrow(CredentialFailure());

          // act
          final result = await repository.addItemInMenu(tAddMenuItemParams);

          // assert
          verify(
            () => mockRemoteDataSource.addItemInMenu(tAddMenuItemParams),
          ).called(1);
          expect(result, Left(CredentialFailure()));
        },
      );

      test(
        'should return Left(Failure) when remoteDataSource.deleteItemInMenu throws ItemNotExistsFailure',
        () async {
          // arrange
          when(
            () => mockLocalDataSource.getRestaurant(),
          ).thenAnswer((_) async => tRestaurantModel);
          when(
            () => mockRemoteDataSource.addItemInMenu(tAddMenuItemParams),
          ).thenThrow(ItemNotExistsFailure());

          // act
          final result = await repository.addItemInMenu(tAddMenuItemParams);

          // assert
          verify(
            () => mockRemoteDataSource.addItemInMenu(tAddMenuItemParams),
          ).called(1);
          expect(result, Left(ItemNotExistsFailure()));
        },
      );

      test(
        'should return Left(Failure) when remoteDataSource.deleteItemInMenu throws ServerFailure',
        () async {
          // arrange
          when(
            () => mockLocalDataSource.getRestaurant(),
          ).thenAnswer((_) async => tRestaurantModel);
          when(
            () => mockRemoteDataSource.addItemInMenu(tAddMenuItemParams),
          ).thenThrow(ServerFailure());

          // act
          final result = await repository.addItemInMenu(tAddMenuItemParams);

          // assert
          verify(
            () => mockRemoteDataSource.addItemInMenu(tAddMenuItemParams),
          ).called(1);
          expect(result, Left(ServerFailure()));
        },
      );
    });

    group('getAllMenuItem', () {
      test(
        'should return Right(Unit) when remoteDataSource.getAllMenuItem succeeds',
        () async {
          // arrange
          when(
            () => mockLocalDataSource.getRestaurant(),
          ).thenAnswer((_) async => tRestaurantModel);
          when(
            () => mockRemoteDataSource.getAllMenuItem(tGetAllMenuItemsParams),
          ).thenAnswer((_) async => tMenuItemsResponseModel);

          // act
          final result = await repository.getAllMenuItem(
            tGetAllMenuItemsParams,
          );

          // assert
          verify(() => mockLocalDataSource.getRestaurant()).called(1);
          verify(
            () => mockRemoteDataSource.getAllMenuItem(tGetAllMenuItemsParams),
          ).called(1);
          expect(result, Right(tMenuItemsResponseModel.menuItems));
        },
      );

      test(
        'should return Left(Failure) when remoteDataSource.getAllMenuItem throws CredentialFailure',
        () async {
          // arrange
          when(
            () => mockLocalDataSource.getRestaurant(),
          ).thenAnswer((_) async => tRestaurantModel);
          when(
            () => mockRemoteDataSource.getAllMenuItem(tGetAllMenuItemsParams),
          ).thenThrow(CredentialFailure());

          // act
          final result = await repository.getAllMenuItem(
            tGetAllMenuItemsParams,
          );

          // assert
          verify(
            () => mockRemoteDataSource.getAllMenuItem(tGetAllMenuItemsParams),
          ).called(1);
          expect(result, Left(CredentialFailure()));
        },
      );

      test(
        'should return Left(Failure) when remoteDataSource.getAllMenuItem throws RestaurantNotExistsFailure',
        () async {
          // arrange
          when(
            () => mockLocalDataSource.getRestaurant(),
          ).thenAnswer((_) async => tRestaurantModel);
          when(
            () => mockRemoteDataSource.getAllMenuItem(tGetAllMenuItemsParams),
          ).thenThrow(RestaurantNotExistsFailure());

          // act
          final result = await repository.getAllMenuItem(
            tGetAllMenuItemsParams,
          );

          // assert
          verify(
            () => mockRemoteDataSource.getAllMenuItem(tGetAllMenuItemsParams),
          ).called(1);
          expect(result, Left(RestaurantNotExistsFailure()));
        },
      );

      test(
        'should return Left(Failure) when remoteDataSource.getAllMenuItem throws ServerFailure',
        () async {
          // arrange
          when(
            () => mockLocalDataSource.getRestaurant(),
          ).thenAnswer((_) async => tRestaurantModel);
          when(
            () => mockRemoteDataSource.getAllMenuItem(tGetAllMenuItemsParams),
          ).thenThrow(ServerFailure());

          // act
          final result = await repository.getAllMenuItem(
            tGetAllMenuItemsParams,
          );

          // assert
          verify(
            () => mockRemoteDataSource.getAllMenuItem(tGetAllMenuItemsParams),
          ).called(1);
          expect(result, Left(ServerFailure()));
        },
      );
    });

    group('increaseItemQuantity', () {
      test(
        'should return Right(MenuItem) when remoteDataSource.increaseItemQuantity succeeds',
        () async {
          // arrange
          when(
            () => mockRemoteDataSource.increaseItemQuantity(tMenuItemModel.id),
          ).thenAnswer((_) async => tMenuItemResponseModel);

          // act
          final result = await repository.increaseItemQuantity(
            tMenuItemModel.id,
          );

          // assert
          verify(
            () => mockRemoteDataSource.increaseItemQuantity(tMenuItemModel.id),
          ).called(1);
          expect(result, Right(tMenuItemResponseModel.menuItemResponseModel));
        },
      );

      test(
        'should return Left(Failure) when remoteDataSource.increaseItemQuantity throws CredentialFailure',
        () async {
          // arrange
          when(
            () => mockRemoteDataSource.increaseItemQuantity(tMenuItemModel.id),
          ).thenThrow(CredentialFailure());

          // act
          final result = await repository.increaseItemQuantity(
            tMenuItemModel.id,
          );

          // assert
          verify(
            () => mockRemoteDataSource.increaseItemQuantity(tMenuItemModel.id),
          ).called(1);
          expect(result, Left(CredentialFailure()));
        },
      );

      test(
        'should return Left(Failure) when remoteDataSource.increaseItemQuantity throws ServerFailure',
        () async {
          // arrange
          when(
            () => mockRemoteDataSource.increaseItemQuantity(tMenuItemModel.id),
          ).thenThrow(ServerFailure());

          // act
          final result = await repository.increaseItemQuantity(
            tMenuItemModel.id,
          );

          // assert
          verify(
            () => mockRemoteDataSource.increaseItemQuantity(tMenuItemModel.id),
          ).called(1);
          expect(result, Left(ServerFailure()));
        },
      );
    });

    group('decreaseItemQuantity', () {
      test(
        'should return Right(MenuItem) when remoteDataSource.decreaseItemQuantity succeeds',
        () async {
          // arrange
          when(
            () => mockRemoteDataSource.decreaseItemQuantity(tMenuItemModel.id),
          ).thenAnswer((_) async => tMenuItemResponseModel);

          // act
          final result = await repository.decreaseItemQuantity(
            tMenuItemModel.id,
          );

          // assert
          verify(
            () => mockRemoteDataSource.decreaseItemQuantity(tMenuItemModel.id),
          ).called(1);
          expect(result, Right(tMenuItemResponseModel.menuItemResponseModel));
        },
      );

      test(
        'should return Left(Failure) when remoteDataSource.decreaseItemQuantity throws CredentialFailure',
        () async {
          // arrange
          when(
            () => mockRemoteDataSource.decreaseItemQuantity(tMenuItemModel.id),
          ).thenThrow(CredentialFailure());

          // act
          final result = await repository.decreaseItemQuantity(
            tMenuItemModel.id,
          );

          // assert
          verify(
            () => mockRemoteDataSource.decreaseItemQuantity(tMenuItemModel.id),
          ).called(1);
          expect(result, Left(CredentialFailure()));
        },
      );

      test(
        'should return Left(Failure) when remoteDataSource.decreaseItemQuantity throws ServerFailure',
        () async {
          // arrange
          when(
            () => mockRemoteDataSource.decreaseItemQuantity(tMenuItemModel.id),
          ).thenThrow(ServerFailure());

          // act
          final result = await repository.decreaseItemQuantity(
            tMenuItemModel.id,
          );

          // assert
          verify(
            () => mockRemoteDataSource.decreaseItemQuantity(tMenuItemModel.id),
          ).called(1);
          expect(result, Left(ServerFailure()));
        },
      );
    });
  });
}
