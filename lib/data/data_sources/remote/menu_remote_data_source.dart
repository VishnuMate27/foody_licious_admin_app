import 'dart:convert';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/get_all_menu_items_usecase.dart';
import 'package:path/path.dart' as p;
import 'package:dartz/dartz.dart';
import 'package:foody_licious_admin_app/core/constants/strings.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/data/models/menuItem/menu_item_model.dart';
import 'package:foody_licious_admin_app/data/models/menuItem/menu_item_response_model.dart';
import 'package:foody_licious_admin_app/data/models/menuItem/menu_items_response_model.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/add_menu_item_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/delete_menu_item_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/update_menu_item_usecase.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

abstract class MenuItemsRemoteDataSource {
  Future<Unit> addItemInMenu(AddMenuItemParams params);
  Future<MenuItemResponseModel> updateItemInMenu(UpdateMenuItemParams params);
  Future<Unit> deleteItemInMenu(DeleteMenuItemParams params);
  Future<MenuItemsResponseModel> getAllMenuItem(GetAllMenuItemsParams params);
  Future<MenuItemResponseModel> increaseItemQuantity(String itemId);
  Future<MenuItemResponseModel> decreaseItemQuantity(String itemId);
}

class MenuItemsRemoteDataSourceImpl extends MenuItemsRemoteDataSource {
  final http.Client client;
  MenuItemsRemoteDataSourceImpl({required this.client});

  @override
  Future<Unit> addItemInMenu(AddMenuItemParams params) {
    return sendAddItemInMenuRequest(params);
  }

  @override
  Future<MenuItemResponseModel> updateItemInMenu(
    UpdateMenuItemParams params,
  ) async {
    return await sendUpdateItemInMenuRequest(params);
  }

  @override
  Future<Unit> deleteItemInMenu(DeleteMenuItemParams params) {
    return sendDeleteItemInMenuRequest(params);
  }

  @override
  Future<MenuItemsResponseModel> getAllMenuItem(GetAllMenuItemsParams params) {
    return sendGetAllMenuItemRequest(params);
  }

  @override
  Future<MenuItemResponseModel> increaseItemQuantity(String itemId) async {
    return await sendIncreaseItemQuantityRequest(itemId);
  }

  @override
  Future<MenuItemResponseModel> decreaseItemQuantity(String itemId) async {
    return await sendDecreaseItemQuantityRequest(itemId);
  }

  Future<Unit> _sendUploadMenuItemImagesRequest(
    AddMenuItemParams params,
  ) async {
    final uri = Uri.parse(
      '$kBaseUrl/api/restaurants/menuItems/upload_menu_item_images',
    );

    final request =
        http.MultipartRequest('POST', uri)
          ..fields['folder'] = 'restaurants'
          ..fields['sub_folder'] = "menu_items"
          ..fields['restaurant_id'] = params.restaurantId!
          ..fields['item_id'] = params.itemId!;

    // Add file
    for (var image in params.imageFilePaths!) {
      request.files.add(await http.MultipartFile.fromPath('images', image));
    }

    // ✅ Send using your existing `client`
    final streamedResponse = await client.send(request);
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return unit;
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialFailure();
    } else {
      throw ServerFailure();
    }
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
      if (params.imageFilePaths != null && params.imageFilePaths!.isNotEmpty) {
        params.itemId =
            menuItemResponseModelFromJson(
              response.body,
            ).menuItemResponseModel.id;
        return _sendUploadMenuItemImagesRequest(params);
      } else {
        return unit;
      }
    } else if (response.statusCode == 404) {
      throw RestaurantNotExistsFailure();
    } else if (response.statusCode == 409) {
      throw ItemAlreadyExistsFailure();
    } else {
      throw ServerFailure();
    }
  }

  // Future<MenuItemResponseModel> sendUpdateItemInMenuRequest(
  //   UpdateMenuItemParams params,
  // ) async {
  //   final response = await client.put(
  //     Uri.parse("$kBaseUrl/api/restaurants/menuItems/updateItem"),
  //     headers: {'Content-Type': 'application/json'},
  //     body: json.encode({
  //       "id": params.id,
  //       "restaurant_id": params.restaurantId,
  //       "name": params.name,
  //       "description": params.description,
  //       "price": params.price,
  //       "availableQuantity": params.availableQuantity,
  //       "ingredients": params.ingredients,
  //       "images": params.images,
  //     }),
  //   );
  //   if (response.statusCode == 200) {
  //     return menuItemResponseModelFromJson(response.body);
  //   } else if (response.statusCode == 404) {
  //     throw RestaurantNotExistsFailure();
  //   } else if (response.statusCode == 409) {
  //     throw ItemAlreadyExistsFailure();
  //   } else {
  //     throw ServerFailure();
  //   }
  // }

  Future<MenuItemResponseModel> sendUpdateItemInMenuRequest(
    UpdateMenuItemParams params,
  ) async {
    final uri = Uri.parse("$kBaseUrl/api/restaurants/menuItems/updateItem");
    final request = http.MultipartRequest('PUT', uri);

    // 🧩 Add non-null text fields only
    if (params.id != null) request.fields['id'] = params.id!;
    if (params.restaurantId != null)
      request.fields['restaurant_id'] = params.restaurantId!;
    if (params.name != null) request.fields['name'] = params.name!;
    if (params.description != null)
      request.fields['description'] = params.description!;
    if (params.price != null)
      request.fields['price'] = params.price!.toString();
    if (params.availableQuantity != null)
      request.fields['availableQuantity'] =
          params.availableQuantity!.toString();

    if (params.ingredients != null) {
      request.fields['ingredients'] = jsonEncode(params.ingredients);
    }

    request.fields['folder'] = 'restaurants';
    request.fields['sub_folder'] = 'menu_items';

    // 🖼️ Handle images (new + existing)
    if (params.images != null && params.images!.isNotEmpty) {
      // Separate new files and existing URLs
      final existingUrls = <String>[];

      for (var image in params.images!) {
        if (image!.startsWith(
          'https://foodylicious.s3.ap-south-1.amazonaws.com/',
        )) {
          existingUrls.add(image);
        } else {
          final fileStream = await http.MultipartFile.fromPath(
            'images',
            image,
            filename: p.basename(image),
          );
          request.files.add(fileStream);
        }
      }

      // Add existing image URLs as JSON string (if any)
      if (existingUrls.isNotEmpty) {
        request.fields['images'] = jsonEncode(existingUrls);
      }
    }

    // Send request
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      return menuItemResponseModelFromJson(responseBody);
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
    GetAllMenuItemsParams params,
  ) async {
    final response = await client.get(
      Uri.parse(
        "$kBaseUrl/api/restaurants/menuItems/allMenuItems?restaurant_id=${params.restaurantId}&page=${params.page}&page_size=${params.limit}",
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

  Future<MenuItemResponseModel> sendIncreaseItemQuantityRequest(
    String itemId,
  ) async {
    final response = await client.put(
      Uri.parse("$kBaseUrl/api/restaurants/menuItems/increaseItemQuantity"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({"id": itemId}),
    );
    if (response.statusCode == 200) {
      return menuItemResponseModelFromJson(response.body);
    } else if (response.statusCode == 400) {
      throw CredentialFailure();
    } else {
      throw ServerFailure();
    }
  }

  Future<MenuItemResponseModel> sendDecreaseItemQuantityRequest(
    String itemId,
  ) async {
    final response = await client.put(
      Uri.parse("$kBaseUrl/api/restaurants/menuItems/decreaseItemQuantity"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({"id": itemId}),
    );
    if (response.statusCode == 200) {
      return menuItemResponseModelFromJson(response.body);
    } else if (response.statusCode == 400) {
      throw CredentialFailure();
    } else {
      throw ServerFailure();
    }
  }
}
