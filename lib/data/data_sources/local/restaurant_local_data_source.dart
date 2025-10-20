import 'dart:async';
import 'package:foody_licious_admin_app/core/error/exceptions.dart';
import 'package:foody_licious_admin_app/data/models/restaurant/restaurant_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class RestaurantLocalDataSource {

  Future<RestaurantModel> getRestaurant();

  Future<void> saveRestaurant(RestaurantModel restaurant);

  Future<void> clearCache();
}

const cachedRestaurant = 'RESTAURANT';

class RestaurantLocalDataSourceImpl implements RestaurantLocalDataSource {
  final SharedPreferences sharedPreferences;
  RestaurantLocalDataSourceImpl(
      {required this.sharedPreferences});


  @override
  Future<RestaurantModel> getRestaurant() async {
    if (sharedPreferences.getBool('first_run') ?? true) {
      sharedPreferences.setBool('first_run', false);
    }
    final jsonString = sharedPreferences.getString(cachedRestaurant);
    if (jsonString != null) {
      return Future.value(restaurantModelFromJson(jsonString));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> saveRestaurant(RestaurantModel restaurant) {
    return sharedPreferences.setString(
      cachedRestaurant,
      restaurantModelToJson(restaurant),
    );
  }

  @override
  Future<void> clearCache() async {
    await sharedPreferences.remove(cachedRestaurant);
  }
}