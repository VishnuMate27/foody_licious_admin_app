import 'package:dartz/dartz.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/domain/entities/restaurant/restaurant.dart';
import 'package:foody_licious_admin_app/domain/usecases/restaurant/update_restaurant_usecase.dart';

abstract class RestaurantRepository {
  Future<Either<Failure, Restaurant>> checkRestaurant();
  Future<Either<Failure, Restaurant>> updateRestaurant(UpdateRestaurantParams params);
  Future<Either<Failure, Restaurant>> updateRestaurantLocation();
  Future<Either<Failure, Unit>> deleteRestaurant();
}