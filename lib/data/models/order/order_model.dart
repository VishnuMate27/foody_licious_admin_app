import 'package:foody_licious_admin_app/data/models/order/order_menu_item_model.dart';
import 'package:foody_licious_admin_app/domain/entities/order/order.dart';
import 'package:foody_licious_admin_app/domain/entities/order/orderMenuItem.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.restaurantId,
    required super.userId,
    required super.status,
    required super.paymentStatus,
    required super.items,
    required super.name,
    required super.address,
    required super.phone,
    required super.totalCartAmount,
    required super.gstCharges,
    required super.platformFees,
    required super.deliveryCharges,
    required super.grandTotalAmount,
    required super.createdAt,
    required super.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final items = json['items'] as List;
    return OrderModel(
      id: json['id'] ?? '',
      restaurantId: json['restaurantId'] ?? '',
      userId: json['userId'] ?? '',
      status: json['status'] ?? '',
      paymentStatus: json['paymentStatus'] ?? '',
      items: json['items'] != null
              ? items.map((e) => OrderMenuItemModel.fromJson(e)).toList()
              : <OrderMenuItemModel>[],
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      totalCartAmount: double.tryParse(json['totalCartAmount'].toString()) ?? 0,
      gstCharges: double.tryParse(json['gstCharges'].toString()) ?? 0,
      platformFees: double.tryParse(json['platformFees'].toString()) ?? 0,
      deliveryCharges: double.tryParse(json['deliveryCharges'].toString()) ?? 0,
      grandTotalAmount:
          double.tryParse(json['grandTotalAmount'].toString()) ?? 0,
      createdAt: DateTime.parse(json['createdAt']['\$date']),
      updatedAt: DateTime.parse(json['updatedAt']['\$date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "restaurantId": restaurantId,
      "userId": userId,
      "status": status,
      "paymentStatus": paymentStatus,
      "items": items,
      "name": name,
      "address": address,
      "phone": phone,
      "totalCartAmount": totalCartAmount,
      "gstCharges": gstCharges,
      "platformFees": platformFees,
      "deliveryCharges": deliveryCharges,
      "grandTotalAmount": grandTotalAmount,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }
}
