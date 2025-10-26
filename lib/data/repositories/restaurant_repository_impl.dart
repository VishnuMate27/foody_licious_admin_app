import 'package:dartz/dartz.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/network/network_info.dart';
import 'package:foody_licious_admin_app/data/data_sources/local/restaurant_local_data_source.dart';
import 'package:foody_licious_admin_app/data/data_sources/remote/restaurant_remote_data_source.dart';
import 'package:foody_licious_admin_app/domain/entities/restaurant/restaurant.dart';
import 'package:foody_licious_admin_app/domain/repositories/restaurant_repository.dart';
import 'package:foody_licious_admin_app/domain/usecases/restaurant/update_restaurant_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/restaurant/upload_restaurant_profile_picture_usecase.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantRemoteDataSource remoteDataSource;
  final RestaurantLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  RestaurantRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Restaurant>> checkRestaurant() async {
    try {
      final restaurant = await localDataSource.getRestaurant();
      return Right(restaurant);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Restaurant>> updateRestaurant(UpdateRestaurantParams params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final restaurant = await localDataSource.getRestaurant();
      params.id = restaurant.id;
      final remoteResponse = await remoteDataSource.updateRestaurant(params);
      await localDataSource.saveRestaurant(remoteResponse.restaurant);
      return Right(remoteResponse.restaurant);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Restaurant>> uploadRestaurantProfilePicture(UploadRestaurantProfilePictureParams params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final restaurant = await localDataSource.getRestaurant();
      params.restaurantId = restaurant.id;
      final remoteResponse = await remoteDataSource.uploadRestaurantProfilePicture(params);
      await localDataSource.saveRestaurant(remoteResponse.restaurant);
      return Right(remoteResponse.restaurant);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Restaurant>> removeRestaurantProfilePicture() async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final restaurant = await localDataSource.getRestaurant();
      final remoteResponse = await remoteDataSource.removeRestaurantProfilePicture(restaurant.id);
      await localDataSource.saveRestaurant(remoteResponse.restaurant);
      return Right(remoteResponse.restaurant);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }


  @override
  Future<Either<Failure, Restaurant>> updateRestaurantLocation() async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final restaurant = await localDataSource.getRestaurant();
      final remoteResponse = await remoteDataSource.updateRestaurantLocation(restaurant.id);
      await localDataSource.saveRestaurant(remoteResponse.restaurant);
      return Right(remoteResponse.restaurant);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteRestaurant() async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final restaurant = await localDataSource.getRestaurant();
      final remoteResponse = await remoteDataSource.deleteRestaurant(restaurant.id);
      await localDataSource.clearCache();
      return Right(remoteResponse);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
