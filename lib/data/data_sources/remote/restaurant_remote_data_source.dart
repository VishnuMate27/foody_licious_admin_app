import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:foody_licious_admin_app/core/constants/strings.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/data/models/restaurant/restaurant_response_model.dart';
import 'package:foody_licious_admin_app/data/services/location_service.dart';
import 'package:foody_licious_admin_app/domain/entities/restaurant/restaurant.dart';
import 'package:foody_licious_admin_app/domain/usecases/restaurant/update_restaurant_usecase.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

abstract class RestaurantRemoteDataSource {
  // Restaurant checkRestaurant();
  Future<RestaurantResponseModel> updateRestaurant(UpdateRestaurantParams restaurant);
  Future<RestaurantResponseModel> updateRestaurantLocation(String restaurantId);
  Future<Unit> deleteRestaurant(String restaurantId);
}

class RestaurantRemoteDataSourceImpl extends RestaurantRemoteDataSource {
  final http.Client client;
  final LocationService locationService;
  Restaurant? restaurant;
  RestaurantRemoteDataSourceImpl({required this.client, required this.locationService,});

  // @override
  // Restaurant checkRestaurant() {
  //   Restaurant restaurant;
  //   restaurant = firebaseAuth.currentRestaurant!;
  //   return restaurant;
  // }

  @override
  Future<RestaurantResponseModel> updateRestaurant(UpdateRestaurantParams params) async {
    return await _sendUpdateRestaurantRequest(params);
  }

  @override
  Future<Unit> deleteRestaurant(String restaurantId) async {
    return await _sendDeleteRestaurantRequest(restaurantId);
  }

  @override
  Future<RestaurantResponseModel> updateRestaurantLocation(String restaurantId) async {
    final position = await locationService.determinePosition();
    return await _sendUpdateLocationRequest(restaurantId, position);
  }

  Future<Unit> _sendDeleteRestaurantRequest(String restaurantId) async {
    final requestBody = json.encode({
      "id": restaurantId,
    });

    final response = await client.post(
      Uri.parse('$kBaseUrl/api/restaurants/delete_restaurant'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: requestBody,
    );

    if (response.statusCode == 200) {
      return unit;
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialFailure();
    } else if (response.statusCode == 404) {
      throw RestaurantNotExistsFailure();
    } else {
      throw ServerFailure();
    }
  }

  Future<RestaurantResponseModel> _sendUpdateRestaurantRequest(
      UpdateRestaurantParams params) async {
    final requestBody = jsonEncode(params.toJson());
    final response = await client.put(
      Uri.parse('$kBaseUrl/api/restaurants/profile'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: requestBody,
    );

    if (response.statusCode == 200) {
      return restaurantResponseModelFromJson(response.body);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialFailure();
    } else {
      throw ServerFailure();
    }
  }

  Future<RestaurantResponseModel> _sendUpdateLocationRequest(
      String restaurantId, Position position) async {
    final requestBody = json.encode({
      "id": restaurantId,
      "address": {
        "coordinates": {
          "type": "Point",
          "coordinates": [position.latitude, position.longitude]
        }
      }
    });

    final response = await client.put(
      Uri.parse('$kBaseUrl/api/restaurants/profile'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: requestBody,
    );

    if (response.statusCode == 200) {
      return restaurantResponseModelFromJson(response.body);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialFailure();
    } else {
      throw ServerFailure();
    }
  }

  Future<Position> _determinePosition() async {
    Position restaurantLocation;
    // 1. Check if services are enabled
    final serviceStatus = await Permission.location.serviceStatus;
    if (!serviceStatus.isEnabled) {
      throw LocationServicesDisabledFailure();
    }

    // 2. Check permission status
    var status = await Permission.location.status;

    if (status.isDenied) {
      status = await Permission.location.request();
      if (status.isDenied) {
        throw LocationPermissionDeniedFailure();
      }
    }

    if (status.isPermanentlyDenied) {
      throw LocationPermissionPermanentlyDeniedFailure();
    }

    // 3. Fetch location
    restaurantLocation = await Geolocator.getCurrentPosition();
    return restaurantLocation;
  }
}
