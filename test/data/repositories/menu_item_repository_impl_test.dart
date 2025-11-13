import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious_admin_app/core/network/network_info.dart';
import 'package:foody_licious_admin_app/data/data_sources/local/restaurant_local_data_source.dart';
import 'package:foody_licious_admin_app/data/data_sources/remote/menu_remote_data_source.dart';
import 'package:foody_licious_admin_app/data/repositories/menu_item_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

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

    //   runTestsOnline(() {
    //   group('updateRestaurant', () {
    //     test(
    //         'should return Right(Restaurant) when remoteDataSource.updateRestaurant succeeds',
    //         () async {
    //       // arrange
    //       when(() => mockLocalDataSource.getRestaurant())
    //           .thenAnswer((_) async => tRestaurantModel);
    //       when(() => mockRemoteDataSource.updateRestaurant(tUpdateRestaurantParams))
    //           .thenAnswer((_) async => tRestaurantResponseModel);
    //       when(() => mockLocalDataSource.saveRestaurant(tRestaurantModel))
    //           .thenAnswer((_) async {});

    //       // act
    //       final result = await repository.updateRestaurant(tUpdateRestaurantParams);

    //       // assert
    //       verify(() => mockLocalDataSource.getRestaurant()).called(1);
    //       verify(() => mockRemoteDataSource.updateRestaurant(tUpdateRestaurantParams))
    //           .called(1);
    //       verify(() => mockLocalDataSource.saveRestaurant(tRestaurantModel)).called(1);
    //       expect(result, Right(tRestaurantModel));
    //     });

    //     test(
    //         'should return Left(Failure) when remoteDataSource.updateRestaurant throws CredentialFailure',
    //         () async {
    //       // arrange
    //       when(() => mockLocalDataSource.getRestaurant())
    //           .thenAnswer((_) async => tRestaurantModel);
    //       when(() => mockRemoteDataSource.updateRestaurant(tUpdateRestaurantParams))
    //           .thenThrow(CredentialFailure());

    //       // act
    //       final result = await repository.updateRestaurant(tUpdateRestaurantParams);

    //       // assert
    //       verify(() => mockRemoteDataSource.updateRestaurant(tUpdateRestaurantParams))
    //           .called(1);
    //       expect(result, Left(CredentialFailure()));
    //     });

    //     test(
    //         'should return Left(Failure) when remoteDataSource.updateRestaurant throws ServerFailure',
    //         () async {
    //       // arrange
    //       when(() => mockLocalDataSource.getRestaurant())
    //           .thenAnswer((_) async => tRestaurantModel);
    //       when(() => mockRemoteDataSource.updateRestaurant(tUpdateRestaurantParams))
    //           .thenThrow(ServerFailure());

    //       // act
    //       final result = await repository.updateRestaurant(tUpdateRestaurantParams);

    //       // assert
    //       verify(() => mockRemoteDataSource.updateRestaurant(tUpdateRestaurantParams))
    //           .called(1);
    //       expect(result, Left(ServerFailure()));
    //     });
    //   });
    // });

    void runTestsOffline(Function body) {
      group('device is offline', () {
        setUp(() {
          when(
            () => mockNetworkInfo.isConnected,
          ).thenAnswer((_) async => false);
        });

        body();
      });
    }
  }
}
