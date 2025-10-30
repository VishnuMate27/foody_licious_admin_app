import 'package:equatable/equatable.dart';

class MenuItem extends Equatable {
  final String id;
  final String restaurantId;
  final String name;
  final int price;
  final int availableQuantity;
  final String? description;
  final List<String>? images;
  final List<String>? ingredients;

  const MenuItem({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.price,
    required this.availableQuantity,
    this.description,
    this.images,
    this.ingredients,
  });

  @override
  List<Object?> get props => [
    id,
    restaurantId,
    name,
    price,
    availableQuantity,
    description,
    images,
    ingredients,
  ];
}
