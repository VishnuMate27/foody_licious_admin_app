part of 'restaurant_bloc.dart';

@immutable 
abstract class RestaurantEvent{}

class CheckRestaurant extends RestaurantEvent {}

class UpdateRestaurant extends RestaurantEvent {
  final UpdateRestaurantParams params;
  UpdateRestaurant(this.params);
}

class UpdateRestaurantLocation extends RestaurantEvent {}

class DeleteRestaurant extends RestaurantEvent {}