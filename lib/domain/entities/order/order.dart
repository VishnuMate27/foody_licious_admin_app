import 'package:equatable/equatable.dart';
import 'package:foody_licious_admin_app/domain/entities/order/orderMenuItem.dart';

enum OrderStatus {
  CONFIRMED,
  PREPARING,
  DISPATCHED,
  DELIVERED,
  CANCELLED_BY_USER,
  CANCELLED_BY_RESTAURANT,
}

class OrderEntity extends Equatable {
  final String id;
  final String restaurantId;
  final String userId;
  final String status;
  final String paymentStatus;
  final List<OrderMenuItem> items;
  final String name;
  final String address;
  final String phone;
  final double totalCartAmount;
  final double gstCharges;
  final double platformFees;
  final double deliveryCharges;
  final double grandTotalAmount;
  final DateTime createdAt;
  final DateTime updatedAt;

  const OrderEntity({
    required this.id,
    required this.restaurantId,
    required this.userId,
    required this.status,
    required this.paymentStatus,
    required this.items,
    required this.name,
    required this.address,
    required this.phone,
    required this.totalCartAmount,
    required this.gstCharges,
    required this.platformFees,
    required this.deliveryCharges,
    required this.grandTotalAmount,
    required this.createdAt,
    required this.updatedAt,
  });

  OrderEntity copyWith({
    String? id,
    String? restaurantId,
    String? userId,
    String? status,
    String? paymentStatus,
    List<OrderMenuItem>? items,
    String? name,
    String? address,
    String? phone,
    double? totalCartAmount,
    double? gstCharges,
    double? platformFees,
    double? deliveryCharges,
    double? grandTotalAmount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return OrderEntity(
      id: id ?? this.id,
      restaurantId: restaurantId ?? this.restaurantId,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      items: items ?? this.items,
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      totalCartAmount: totalCartAmount ?? this.totalCartAmount,
      gstCharges: gstCharges ?? this.gstCharges,
      platformFees: platformFees ?? this.platformFees,
      deliveryCharges: deliveryCharges ?? this.deliveryCharges,
      grandTotalAmount: grandTotalAmount ?? this.grandTotalAmount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [id, restaurantId, userId, status, paymentStatus];
}
