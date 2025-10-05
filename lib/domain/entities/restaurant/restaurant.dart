import 'package:equatable/equatable.dart';
import 'package:foody_licious_admin_app/data/models/restaurant/restaurant_model.dart';

class Restaurant extends Equatable {
  final String id;
  final String name;
  final String ownerName;
  final String? email;
  final String? phone;
  final String? authProvider;
  final AddressModel? address;
  final String? photo;
  final String? description;
  final List<String>? menuItems;
  final List<String>? receivedOrders;
  final List<String>? receivedFeedback;

  const Restaurant({
    required this.id,
    required this.name,
    required this.ownerName,
    this.email,
    this.phone,
    this.authProvider,
    this.address,
    this.photo,
    this.description,
    this.menuItems,
    this.receivedOrders,
    this.receivedFeedback,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    ownerName,
    email,
    phone,
    authProvider,
    address,
    photo,
    description,
    menuItems,
    receivedOrders,
    receivedFeedback,
  ];
}

class Address extends Equatable {
  final String? addressText;
  final String? city;
  final Coordinates? coordinates;

  const Address({this.addressText, this.city, this.coordinates});

  @override
  List<Object?> get props => [addressText, city, coordinates];
}

class Coordinates extends Equatable {
  final String? type;
  final List<double>? coordinates;

  const Coordinates({this.type, this.coordinates});

  @override
  List<Object?> get props => [type, coordinates];
}
