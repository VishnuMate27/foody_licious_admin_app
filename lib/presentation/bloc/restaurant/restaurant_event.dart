part of 'restaurant_bloc.dart';

@immutable 
abstract class RestaurantEvent{}

class CheckRestaurant extends RestaurantEvent {}

class UpdateRestaurant extends RestaurantEvent {
  final UpdateRestaurantParams params;
  UpdateRestaurant(this.params);
}

class UploadRestaurantProfilePicture extends RestaurantEvent {
  final UploadRestaurantProfilePictureParams params;
  UploadRestaurantProfilePicture(this.params);
}

class RemoveRestaurantProfilePicture extends RestaurantEvent {}

class UpdateRestaurantLocation extends RestaurantEvent {}

class DeleteRestaurant extends RestaurantEvent {}