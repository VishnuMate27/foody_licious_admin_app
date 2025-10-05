import 'dart:convert';

import 'restaurant_model.dart';

AuthenticationResponseModel authenticationResponseModelFromJson(String str) =>
    AuthenticationResponseModel.fromJson(json.decode(str));

String authenticationResponseModelToJson(AuthenticationResponseModel data) =>
    json.encode(data.toJson());

class AuthenticationResponseModel {
  final RestaurantModel restaurant;

  const AuthenticationResponseModel({
    required this.restaurant,
  });

  factory AuthenticationResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthenticationResponseModel(
      restaurant: RestaurantModel.fromJson(json["restaurant"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "restaurant": restaurant.toJson(),
      };
}
