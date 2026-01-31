import 'dart:convert';
import 'package:foody_licious_admin_app/data/models/order/order_model.dart';

OrdersResponseModel ordersResponseModelFromJson(String str) =>
    OrdersResponseModel.fromJson(json.decode(str));

String ordersResponseModelToJson(OrdersResponseModel data) =>
    json.encode(data.toJson());

class OrdersResponseModel {
  final List<OrderModel> orders;
  const OrdersResponseModel({required this.orders});

  factory OrdersResponseModel.fromJson(Map<String, dynamic> json) {
    final orders = json['orders'] as List;
    return OrdersResponseModel(
      orders: orders.map((e) => OrderModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {"orders": orders.map((e) => e.toJson()).toList()};
  }
}
