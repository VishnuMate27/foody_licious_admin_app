import 'dart:convert';

import 'package:foody_licious_admin_app/domain/entities/menuItem/menuItem.dart';

MenuItemModel menuItemModelFromJson(String str) => MenuItemModel.fromJson(
 json.decode(str)
);

String menuItemModelToJson(MenuItemModel data) =>
    json.encode(data.toJson());

class MenuItemModel extends MenuItem {
  const MenuItemModel({
    required super.id,
    required super.restaurantId,
    required super.name,
    required super.price,
    super.description,
    super.images,
    super.ingredients,
  });

  factory MenuItemModel.fromJson(Map<String, dynamic> json) {
    return MenuItemModel(
      id: json['id'],
      restaurantId: json['restaurantId'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
      images: json['images'],
      ingredients: json['ingredients'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "restaurantId": restaurantId,
      "name": name,
      "price": price,
      "description": description,
      "images": images,
      "ingredients": ingredients,
    };
  }
}
