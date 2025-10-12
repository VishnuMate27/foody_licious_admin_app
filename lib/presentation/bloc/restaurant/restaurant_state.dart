part of 'restaurant_bloc.dart';

@immutable
abstract class RestaurantState extends Equatable{}

class RestaurantInitial extends RestaurantState{
  @override
  List<Object> get props => [];
}

class RestaurantLoading extends RestaurantState {
  @override
  List<Object> get props => [];
}

class RestaurantAuthenticated extends RestaurantState{
  final Restaurant restaurant;
  RestaurantAuthenticated(this.restaurant);
  @override
  List<Object> get props => [restaurant];
}

class RestaurantUnauthenticated extends RestaurantState{
  final Failure failure;
  RestaurantUnauthenticated(this.failure);
  @override
  List<Object> get props => [];
}


class RestaurantUpdateSuccess extends RestaurantState {
  final Restaurant restaurant;
  RestaurantUpdateSuccess(this.restaurant);
  @override
  List<Object> get props => [restaurant];
}

class RestaurantUpdateFailed extends RestaurantState {
  final Failure failure;
  RestaurantUpdateFailed(this.failure);
  @override
  List<Object> get props => [];
}

class RestaurantLocationUpdating extends RestaurantState {
  @override
  List<Object> get props => [];
}

class RestaurantUpdateLocationSuccess extends RestaurantState {
  final Restaurant restaurant;
  RestaurantUpdateLocationSuccess(this.restaurant);
  @override
  List<Object> get props => [restaurant];
}

class RestaurantUpdateLocationFailed extends RestaurantState {
  final Failure failure;
  RestaurantUpdateLocationFailed(this.failure);
  @override
  List<Object> get props => [];
}

class RestaurantDeleteSuccess extends RestaurantState {
  final Unit unit;
  RestaurantDeleteSuccess(this.unit);
  @override
  List<Object> get props => [unit];
}

class RestaurantDeleteFailed extends RestaurantState {
  final Failure failure;
  RestaurantDeleteFailed(this.failure);
  @override
  List<Object> get props => [];
}

