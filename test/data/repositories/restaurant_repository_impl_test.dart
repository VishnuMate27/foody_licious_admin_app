import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/network/network_info.dart';
import 'package:foody_licious_admin_app/data/data_sources/local/restaurant_local_data_source.dart';
import 'package:foody_licious_admin_app/data/data_sources/remote/restaurant_remote_data_source.dart';
import 'package:foody_licious_admin_app/data/repositories/restaurant_repository_impl.dart';
import 'package:mocktail/mocktail.dart';
import '../../fixtures/constant_objects.dart';

class MockRemoteDataSource extends Mock implements RestaurantRemoteDataSource {}

class MockLocalDataSource extends Mock implements RestaurantLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late RestaurantRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = RestaurantRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
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
    group('updateRestaurant', () {
      test(
          'should return Right(Restaurant) when remoteDataSource.updateRestaurant succeeds',
          () async {
        // arrange
        when(() => mockLocalDataSource.getRestaurant())
            .thenAnswer((_) async => tRestaurantModel);
        when(() => mockRemoteDataSource.updateRestaurant(tUpdateRestaurantParams))
            .thenAnswer((_) async => tRestaurantResponseModel);
        when(() => mockLocalDataSource.saveRestaurant(tRestaurantModel))
            .thenAnswer((_) async {});

        // act
        final result = await repository.updateRestaurant(tUpdateRestaurantParams);

        // assert
        verify(() => mockLocalDataSource.getRestaurant()).called(1);
        verify(() => mockRemoteDataSource.updateRestaurant(tUpdateRestaurantParams))
            .called(1);
        verify(() => mockLocalDataSource.saveRestaurant(tRestaurantModel)).called(1);
        expect(result, Right(tRestaurantModel));
      });

      test(
          'should return Left(Failure) when remoteDataSource.updateRestaurant throws CredentialFailure',
          () async {
        // arrange
        when(() => mockLocalDataSource.getRestaurant())
            .thenAnswer((_) async => tRestaurantModel);
        when(() => mockRemoteDataSource.updateRestaurant(tUpdateRestaurantParams))
            .thenThrow(CredentialFailure());

        // act
        final result = await repository.updateRestaurant(tUpdateRestaurantParams);

        // assert
        verify(() => mockRemoteDataSource.updateRestaurant(tUpdateRestaurantParams))
            .called(1);
        expect(result, Left(CredentialFailure()));
      });

      test(
          'should return Left(Failure) when remoteDataSource.updateRestaurant throws ServerFailure',
          () async {
        // arrange
        when(() => mockLocalDataSource.getRestaurant())
            .thenAnswer((_) async => tRestaurantModel);
        when(() => mockRemoteDataSource.updateRestaurant(tUpdateRestaurantParams))
            .thenThrow(ServerFailure());

        // act
        final result = await repository.updateRestaurant(tUpdateRestaurantParams);

        // assert
        verify(() => mockRemoteDataSource.updateRestaurant(tUpdateRestaurantParams))
            .called(1);
        expect(result, Left(ServerFailure()));
      });
    });
    group('updateRestaurantLocation', () {
      test(
          'should return Right(Restaurant) when remoteDataSource.updateRestaurantLocation succeeds',
          () async {
        // arrange
        when(() => mockLocalDataSource.getRestaurant())
            .thenAnswer((_) async => tRestaurantModel);
        when(() => mockRemoteDataSource.updateRestaurantLocation(tRestaurantModel.id))
            .thenAnswer((_) async => tRestaurantResponseModel);
        when(() => mockLocalDataSource.saveRestaurant(tRestaurantModel))
            .thenAnswer((_) async {});

        // act
        final result = await repository.updateRestaurantLocation();

        // assert
        verify(() => mockLocalDataSource.getRestaurant()).called(1);
        verify(() => mockRemoteDataSource.updateRestaurantLocation(tRestaurantModel.id))
            .called(1);
        verify(() => mockLocalDataSource.saveRestaurant(tRestaurantModel)).called(1);
        expect(result, Right(tRestaurantModel));
      });

      test(
          'should return Left(Failure) when remoteDataSource.updateRestaurantLocation throws CredentialFailure',
          () async {
        // arrange
        when(() => mockLocalDataSource.getRestaurant())
            .thenAnswer((_) async => tRestaurantModel);
        when(() => mockRemoteDataSource.updateRestaurantLocation(tRestaurantModel.id))
            .thenThrow(CredentialFailure());

        // act
        final result = await repository.updateRestaurantLocation();

        // assert
        verify(() => mockRemoteDataSource.updateRestaurantLocation(tRestaurantModel.id))
            .called(1);
        expect(result, Left(CredentialFailure()));
      });

      test(
          'should return Left(Failure) when remoteDataSource.updateRestaurantLocation throws ServerFailure',
          () async {
        // arrange
        when(() => mockLocalDataSource.getRestaurant())
            .thenAnswer((_) async => tRestaurantModel);
        when(() => mockRemoteDataSource.updateRestaurantLocation(tRestaurantModel.id))
            .thenThrow(ServerFailure());

        // act
        final result = await repository.updateRestaurantLocation();

        // assert
        verify(() => mockRemoteDataSource.updateRestaurantLocation(tRestaurantModel.id))
            .called(1);
        expect(result, Left(ServerFailure()));
      });
    });
    group('uploadRestaurantProfilePicture', () {
      test(
          'should return Right(Restaurant) when remoteDataSource.uploadRestaurantProfilePicture succeeds',
          () async {
        // arrange
        when(() => mockLocalDataSource.getRestaurant())
            .thenAnswer((_) async => tRestaurantModel);
        when(() => mockRemoteDataSource.uploadRestaurantProfilePicture(tUploadRestaurantProfilePictureParams))
            .thenAnswer((_) async => tRestaurantResponseModel);
        when(() => mockLocalDataSource.saveRestaurant(tRestaurantModel))
            .thenAnswer((_) async {});

        // act
        final result = await repository.uploadRestaurantProfilePicture(tUploadRestaurantProfilePictureParams);

        // assert
        verify(() => mockLocalDataSource.getRestaurant()).called(1);
        verify(() => mockRemoteDataSource.uploadRestaurantProfilePicture(tUploadRestaurantProfilePictureParams))
            .called(1);
        verify(() => mockLocalDataSource.saveRestaurant(tRestaurantModel)).called(1);
        expect(result, Right(tRestaurantModel));
      });

      test(
          'should return Left(Failure) when remoteDataSource.uploadRestaurantProfilePicture throws CredentialFailure',
          () async {
        // arrange
        when(() => mockLocalDataSource.getRestaurant())
            .thenAnswer((_) async => tRestaurantModel);
        when(() => mockRemoteDataSource.uploadRestaurantProfilePicture(tUploadRestaurantProfilePictureParams))
            .thenThrow(CredentialFailure());

        // act
        final result = await repository.uploadRestaurantProfilePicture(tUploadRestaurantProfilePictureParams);

        // assert
        verify(() => mockRemoteDataSource.uploadRestaurantProfilePicture(tUploadRestaurantProfilePictureParams))
            .called(1);
        expect(result, Left(CredentialFailure()));
      });

      test(
          'should return Left(Failure) when remoteDataSource.uploadRestaurantProfilePicture throws ServerFailure',
          () async {
        // arrange
        when(() => mockLocalDataSource.getRestaurant())
            .thenAnswer((_) async => tRestaurantModel);
        when(() => mockRemoteDataSource.uploadRestaurantProfilePicture(tUploadRestaurantProfilePictureParams))
            .thenThrow(ServerFailure());

        // act
        final result = await repository.uploadRestaurantProfilePicture(tUploadRestaurantProfilePictureParams);

        // assert
        verify(() => mockRemoteDataSource.uploadRestaurantProfilePicture(tUploadRestaurantProfilePictureParams))
            .called(1);
        expect(result, Left(ServerFailure()));
      });
    });
    group('removeRestaurantProfilePicture', () {
      test(
          'should return Right(Restaurant) when remoteDataSource.removeRestaurantProfilePicture succeeds',
          () async {
        // arrange
        when(() => mockLocalDataSource.getRestaurant())
            .thenAnswer((_) async => tRestaurantModel);
        when(() => mockRemoteDataSource.removeRestaurantProfilePicture(tRestaurantModel.id))
            .thenAnswer((_) async => tRestaurantResponseModel);
        when(() => mockLocalDataSource.saveRestaurant(tRestaurantModel))
            .thenAnswer((_) async {});

        // act
        final result = await repository.removeRestaurantProfilePicture();

        // assert
        verify(() => mockLocalDataSource.getRestaurant()).called(1);
        verify(() => mockRemoteDataSource.removeRestaurantProfilePicture(tRestaurantModel.id))
            .called(1);
        verify(() => mockLocalDataSource.saveRestaurant(tRestaurantModel)).called(1);
        expect(result, Right(tRestaurantModel));
      });

      test(
          'should return Left(Failure) when remoteDataSource.removeRestaurantProfilePicture throws CredentialFailure',
          () async {
        // arrange
        when(() => mockLocalDataSource.getRestaurant())
            .thenAnswer((_) async => tRestaurantModel);
        when(() => mockRemoteDataSource.removeRestaurantProfilePicture(tRestaurantModel.id))
            .thenThrow(CredentialFailure());

        // act
        final result = await repository.removeRestaurantProfilePicture();

        // assert
        verify(() => mockRemoteDataSource.removeRestaurantProfilePicture(tRestaurantModel.id))
            .called(1);
        expect(result, Left(CredentialFailure()));
      });

      test(
          'should return Left(Failure) when remoteDataSource.removeRestaurantProfilePicture throws ServerFailure',
          () async {
        // arrange
        when(() => mockLocalDataSource.getRestaurant())
            .thenAnswer((_) async => tRestaurantModel);
        when(() => mockRemoteDataSource.removeRestaurantProfilePicture(tRestaurantModel.id))
            .thenThrow(ServerFailure());

        // act
        final result = await repository.removeRestaurantProfilePicture();

        // assert
        verify(() => mockRemoteDataSource.removeRestaurantProfilePicture(tRestaurantModel.id))
            .called(1);
        expect(result, Left(ServerFailure()));
      });
    });    
    group('deleteRestaurant', () {
      test(
          'should return Right(Unit) when remoteDataSource.deleteRestaurant succeeds',
          () async {
        when(() => mockLocalDataSource.getRestaurant())
            .thenAnswer((_) async => tRestaurantModel);
        when(() => mockRemoteDataSource.deleteRestaurant(tRestaurantModel.id))
            .thenAnswer((_) async => unit);
        when(() => mockLocalDataSource.clearCache()).thenAnswer((_) async {});

        // act
        final result = await repository.deleteRestaurant();

        // assert
        verify(() => mockLocalDataSource.getRestaurant()).called(1);
        verify(() => mockRemoteDataSource.deleteRestaurant(tRestaurantModel.id)).called(1);
        verify(() => mockLocalDataSource.clearCache()).called(1);
        expect(result, Right(unit));
      });

      test(
          'should return Left(Failure) when remoteDataSource.deleteRestaurant throws CredentialFailure',
          () async {
        // arrange
        when(() => mockLocalDataSource.getRestaurant())
            .thenAnswer((_) async => tRestaurantModel);
        when(() => mockRemoteDataSource.deleteRestaurant(tRestaurantModel.id))
            .thenThrow(CredentialFailure());

        // act
        final result = await repository.deleteRestaurant();

        // assert
        verify(() => mockRemoteDataSource.deleteRestaurant(tRestaurantModel.id)).called(1);
        expect(result, Left(CredentialFailure()));
      });

      test(
          'should return Left(Failure) when remoteDataSource.deleteRestaurant throws RestaurantNotExistsFailure',
          () async {
        // arrange
        when(() => mockLocalDataSource.getRestaurant())
            .thenAnswer((_) async => tRestaurantModel);
        when(() => mockRemoteDataSource.deleteRestaurant(tRestaurantModel.id))
            .thenThrow(RestaurantNotExistsFailure());

        // act
        final result = await repository.deleteRestaurant();

        // assert
        verify(() => mockRemoteDataSource.deleteRestaurant(tRestaurantModel.id)).called(1);
        expect(result, Left(RestaurantNotExistsFailure()));
      });

      test(
          'should return Left(Failure) when remoteDataSource.deleteRestaurant throws ServerFailure',
          () async {
        // arrange
        when(() => mockLocalDataSource.getRestaurant())
            .thenAnswer((_) async => tRestaurantModel);
        when(() => mockRemoteDataSource.deleteRestaurant(tRestaurantModel.id))
            .thenThrow(ServerFailure());

        // act
        final result = await repository.deleteRestaurant();

        // assert
        verify(() => mockRemoteDataSource.deleteRestaurant(tRestaurantModel.id)).called(1);
        expect(result, Left(ServerFailure()));
      });
    });
  });

  runTestsOffline(() {
    group('checkRestaurant', () {
      test('should return Right(Restaurant) when localDataSource.getRestaurant succeeds',
          () async {
        // arrange
        when(() => mockLocalDataSource.getRestaurant())
            .thenAnswer((_) async => tRestaurantModel);

        // act
        final result = await repository.checkRestaurant();

        // assert
        verify(() => mockLocalDataSource.getRestaurant()).called(1);
        expect(result, Right(tRestaurantModel));
      });

      test(
          'should return Left(Failure) when localDataSource.getRestaurant throws Failure',
          () async {
        // arrange
        final tFailure = CacheFailure();
        when(() => mockLocalDataSource.getRestaurant()).thenThrow(tFailure);

        // act
        final result = await repository.checkRestaurant();

        // assert
        verify(() => mockLocalDataSource.getRestaurant()).called(1);
        expect(result, Left(tFailure));
      });
    });
  });
}
