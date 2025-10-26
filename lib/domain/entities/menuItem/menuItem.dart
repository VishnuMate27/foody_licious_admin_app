import 'package:equatable/equatable.dart';

class MenuItem extends Equatable {
  final String id;
  final String restaurantId;
  final String name;
  final String price;
  final String? description;
  final String? image;
  final List<String>? ingredients;

  const MenuItem({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.price,
    this.description,
    this.image,
    this.ingredients,
  });

  @override
  List<Object?> get props => [
    id,
    restaurantId,
    name,
    price,
    description,
    image,
    ingredients,
  ];
}
