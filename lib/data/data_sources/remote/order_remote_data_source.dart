import 'dart:convert';
import 'package:foody_licious_admin_app/core/constants/strings.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/data/models/order/order_response_model.dart';
import 'package:foody_licious_admin_app/data/models/order/orders_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:foody_licious_admin_app/domain/usecases/order/get_all_order_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/order/update_order_status_usecase.dart';

abstract class OrderRemoteDataSource {
  Future<OrdersResponseModel> getAllOrders(GetAllOrdersParams params);
  Future<OrderResponseModel> updateOrderStatus(UpdateOrderStatusParams params);
}

class OrderRemoteDataSourceImpl extends OrderRemoteDataSource {
  final http.Client client;
  OrderRemoteDataSourceImpl({required this.client});

  @override
  Future<OrdersResponseModel> getAllOrders(GetAllOrdersParams params) {
    return sendGetAllOrdersRequest(params);
  }

  @override
  Future<OrderResponseModel> updateOrderStatus(UpdateOrderStatusParams params) {
    return sendUpdateOrderStatusRequest(params);
  }

  Future<OrdersResponseModel> sendGetAllOrdersRequest(
    GetAllOrdersParams params,
  ) async {
    String urlEndpoint = '';
    if (params.statuses != null) {
      urlEndpoint = params.statuses!.join("&status=");
    }
    final response = await client.get(
      Uri.parse(
        "$kBaseUrl/api/restaurants/order/getAllOrders?restaurant_id=${params.restaurantId}&page=${params.page}&page_size=${params.limit}&status=$urlEndpoint",
      ),
    );
    if (response.statusCode == 200) {
      return ordersResponseModelFromJson(response.body);
    } else if (response.statusCode == 400) {
      throw CredentialFailure();
    } else if (response.statusCode == 404) {
      throw RestaurantNotExistsFailure();
    } else {
      throw ServerFailure();
    }
  }

  Future<OrderResponseModel> sendUpdateOrderStatusRequest(
    UpdateOrderStatusParams params,
  ) async {
    final requestBody = json.encode({
      "orderId": params.orderId,
      "restaurantId": params.restaurantId,
      "status": params.status,
    });
    final response = await client.post(
      Uri.parse("$kBaseUrl/api/restaurants/order/updateOrderStatus"),
      headers: {'Content-Type': 'application/json'},
      body: requestBody,
    );
    if (response.statusCode == 200) {
      return orderResponseModelFromJson(response.body);
    } else if (response.statusCode == 400) {
      throw CredentialFailure();
    } else if (response.statusCode == 401) {
      throw UnauthorizedRequestFailure();
    } else if (response.statusCode == 404) {
      throw OrderNotExistsFailure();
    } else {
      throw ServerFailure();
    }
  }
}
