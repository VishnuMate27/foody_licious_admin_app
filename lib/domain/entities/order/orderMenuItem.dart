import 'package:equatable/equatable.dart';
import 'package:foody_licious_admin_app/domain/entities/menuItem/menuItem.dart';

class OrderMenuItem extends Equatable {
  final String id;
  final int quantity;
  final double totalPrice;
  final MenuItem menuItemDetails;
  final double? price;
  final int? availableQuantity;

  const OrderMenuItem({
    required this.id,
    required this.quantity,
    required this.totalPrice,
    required this.menuItemDetails,
    this.price,
    this.availableQuantity,
  });

  OrderMenuItem copyWith({
    String? id,
    int? quantity,
    double? totalPrice,
    MenuItem? menuItemDetails,
    double? price,
    int? availableQuantity,
  }) {
    return OrderMenuItem(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
      menuItemDetails: menuItemDetails ?? this.menuItemDetails,
    );
  }

  @override
  List<Object> get props => [id, quantity, totalPrice, menuItemDetails];
}
