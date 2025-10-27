import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:foody_licious_admin_app/core/constants/strings.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/data/models/menuItem/menu_item_model.dart';
import 'package:foody_licious_admin_app/data/models/menuItem/menu_item_response_model.dart';
import 'package:foody_licious_admin_app/data/models/menuItem/menu_items_response_model.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/add_menu_item_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/delete_menu_item_usecase.dart';
import 'package:http/http.dart' as http;

abstract class MenuItemsRemoteDataSource {
  Future<Unit> addItemInMenu(AddMenuItemParams params);
  Future<Unit> deleteItemInMenu(DeleteMenuItemParams params);
  Future<MenuItemsResponseModel> getAllMenuItem(String restaurantId);
  Future<Unit> increaseItemQuantity(String itemId);
  Future<Unit> decreaseItemQuantity(String itemId);
}

class MenuItemsRemoteDataSourceImpl extends MenuItemsRemoteDataSource {
  final http.Client client;
  MenuItemsRemoteDataSourceImpl({required this.client});

  @override
  Future<Unit> addItemInMenu(AddMenuItemParams params) {
    return sendAddItemInMenuRequest(params);
  }

  @override
  Future<Unit> deleteItemInMenu(DeleteMenuItemParams params) {
    return sendDeleteItemInMenuRequest(params);
  }

  @override
  Future<MenuItemsResponseModel> getAllMenuItem(String restaurantId) {
    return sendGetAllMenuItemRequest(restaurantId);
  }

  @override
  Future<Unit> increaseItemQuantity(String itemId) async {
    return await sendIncreaseItemQuantityRequest(itemId);
  }

  @override
  Future<Unit> decreaseItemQuantity(String itemId) async {
    return await sendDecreaseItemQuantityRequest(itemId);
  }

  Future<Unit> sendAddItemInMenuRequest(AddMenuItemParams params) async {
    final response = await client.post(
      Uri.parse("$kBaseUrl/api/restaurants/menuItems/addNewItem"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "restaurant_id": params.restaurantId,
        "name": params.name,
        "description": params.description,
        "price": params.price,
        "availableQuantity": params.availableQuantity,
        "ingredients": params.ingredients,
      }),
    );
    if (response.statusCode == 201) {
      return unit;
    } else if (response.statusCode == 404) {
      throw RestaurantNotExistsFailure();
    } else if (response.statusCode == 409) {
      throw ItemAlreadyExistsFailure();
    } else {
      throw ServerFailure();
    }
  }

  Future<Unit> sendDeleteItemInMenuRequest(DeleteMenuItemParams params) async {
    final response = await client.delete(
      Uri.parse("$kBaseUrl/api/restaurants/menuItems/deleteItem"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({"id": params.itemId}),
    );
    if (response.statusCode == 200) {
      return unit;
    } else if (response.statusCode == 400) {
      throw CredentialFailure();
    } else if (response.statusCode == 404) {
      throw ItemNotExistsFailure();
    } else {
      throw ServerFailure();
    }
  }

  Future<MenuItemsResponseModel> sendGetAllMenuItemRequest(
    String restaurantId,
  ) async {
    final response = await client.get(
      Uri.parse(
        "$kBaseUrl/api/restaurants/menuItems/allMenuItems?restaurant_id=$restaurantId",
      ),
    );
    if (response.statusCode == 200) {
      return menuItemsResponseModelFromJson(response.body);
    } else if (response.statusCode == 400) {
      throw CredentialFailure();
    } else if (response.statusCode == 404) {
      throw ItemNotExistsFailure();
    } else {
      throw ServerFailure();
    }
  }

  Future<Unit> sendIncreaseItemQuantityRequest(String itemId) async {
    final response = await client.put(
      Uri.parse("$kBaseUrl/api/restaurants/menuItems/increaseItemQuantity"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({"id": itemId}),
    );
    if (response.statusCode == 200) {
      return unit;
    } else {
      throw ServerFailure();
    }
  }

  Future<Unit> sendDecreaseItemQuantityRequest(String itemId) async {
    final response = await client.put(
      Uri.parse("$kBaseUrl/api/restaurants/menuItems/decreaseItemQuantity"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({"id": itemId}),
    );
    if (response.statusCode == 200) {
      return unit;
    } else {
      throw ServerFailure();
    }
  }
}
