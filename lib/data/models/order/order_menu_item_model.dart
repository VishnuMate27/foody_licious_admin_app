import 'package:foody_licious_admin_app/data/models/menuItem/menu_item_model.dart';
import 'package:foody_licious_admin_app/domain/entities/order/orderMenuItem.dart';

class OrderMenuItemModel extends OrderMenuItem {
  const OrderMenuItemModel({
    required super.id,
    required super.quantity,
    required super.totalPrice,
    required super.menuItemDetails,
    required super.price,
    required super.availableQuantity,
  });

  factory OrderMenuItemModel.fromJson(Map<String, dynamic> json) {
    return OrderMenuItemModel(
      id: json['menuItemId'] ?? '',
      quantity:int.tryParse(json['quantity'].toString()) ?? 0,
      totalPrice: double.tryParse(json['totalPrice'].toString()) ?? 0,
      menuItemDetails: MenuItemModel.fromJson(json['menuItemDetails']),
      price: double.tryParse(json['price'].toString()) ?? 0,
      availableQuantity: int.tryParse(json['availableQuantity'].toString()) ?? 0,
    );
  }
}
