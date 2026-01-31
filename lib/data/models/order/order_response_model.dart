import 'dart:convert';
import 'package:foody_licious_admin_app/data/models/order/order_model.dart';

OrderResponseModel orderResponseModelFromJson(String str) =>
    OrderResponseModel.fromJson(json.decode(str));

String orderResponseModelToJson(OrderResponseModel data) =>
    json.encode(data.toJson());

class OrderResponseModel {
  final OrderModel orderResponseModel;
  const OrderResponseModel({required this.orderResponseModel});

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) {
    return OrderResponseModel(orderResponseModel: OrderModel.fromJson(json['order']));
  }

  Map<String, dynamic> toJson() {
    return {"order": orderResponseModel};
  }
}
