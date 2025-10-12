import 'package:dartz/dartz.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/usecase/usecase.dart';
import 'package:foody_licious_admin_app/data/models/restaurant/restaurant_model.dart';
import 'package:foody_licious_admin_app/domain/entities/restaurant/restaurant.dart';
import 'package:foody_licious_admin_app/domain/repositories/restaurant_repository.dart';

class UpdateRestaurantUseCase extends UseCase<Restaurant, UpdateRestaurantParams> {
  final RestaurantRepository repository;
  UpdateRestaurantUseCase(this.repository);

  @override
  Future<Either<Failure, Restaurant>> call(UpdateRestaurantParams params) async {
    return await repository.updateRestaurant(params);
  }
}

class UpdateRestaurantParams {
  String? id;
  final String? name;
  final String? email;
  final String? phone;
  final AddressModel? address;
  final List<String>? orderHistory;
  final String? photo;
  final String? description;
  final String? menuItems;

  UpdateRestaurantParams({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.orderHistory,
    this.photo,
    this.description,
    this.menuItems,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (id != null) data['id'] = id;
    if (name != null) data['name'] = name;
    if (email != null) data['email'] = email;
    if (phone != null) data['phone'] = phone;
    if (address != null) data['address'] = address!.toJson();
    if (orderHistory != null) data['orderHistory'] = orderHistory;
    if (photo != null) data['photo'] = photo;
    if (description != null) data['description'] = description;
    if (menuItems != null) data['menuItems'] = menuItems;  
    return data;
  }
}