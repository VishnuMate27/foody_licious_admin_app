import 'package:dartz/dartz.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/network/network_info.dart';
import 'package:foody_licious_admin_app/data/data_sources/local/restaurant_local_data_source.dart';
import 'package:foody_licious_admin_app/data/data_sources/remote/menu_remote_data_source.dart';
import 'package:foody_licious_admin_app/data/models/menuItem/menu_items_response_model.dart';
import 'package:foody_licious_admin_app/domain/repositories/menu_item_repository.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/add_menu_item_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/delete_menu_item_usecase.dart';

class MenuItemRepositoryImpl implements MenuItemRepository {
  final MenuItemsRemoteDataSource menuItemsRemoteDataSource;
  final RestaurantLocalDataSource restaurantLocalDataSource;
  final NetworkInfo networkInfo;

  MenuItemRepositoryImpl({
    required this.menuItemsRemoteDataSource,
    required this.restaurantLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Unit>> addItemInMenu(AddMenuItemParams params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final restaurant = await restaurantLocalDataSource.getRestaurant();
      params.restaurantId = restaurant.id;
      final remoteResponse = await menuItemsRemoteDataSource.addItemInMenu(
        params,
      );
      return Right(remoteResponse);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteItemInMenu(
    DeleteMenuItemParams params,
  ) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final remoteResponse = await menuItemsRemoteDataSource.deleteItemInMenu(
        params,
      );
      return Right(remoteResponse);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, MenuItemsResponseModel>> getAllMenuItem() async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }    
    try {
      final restaurant = await restaurantLocalDataSource.getRestaurant();
      final remoteResponse = await menuItemsRemoteDataSource.getAllMenuItem(
        restaurant.id,
      );
      return Right(remoteResponse);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> increaseItemQuantity(String itemId) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }    
    try {
      final remoteResponse = await menuItemsRemoteDataSource
          .increaseItemQuantity(itemId);
      return Right(remoteResponse);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> decreaseItemQuantity(String itemId) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }    
    try {
      final remoteResponse = await menuItemsRemoteDataSource
          .decreaseItemQuantity(itemId);
      return Right(remoteResponse);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
