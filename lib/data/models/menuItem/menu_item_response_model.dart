import 'dart:convert';

import 'package:foody_licious_admin_app/data/models/menuItem/menu_item_model.dart';

MenuItemResponseModel menuItemModelFromJson(String str) =>
    MenuItemResponseModel.fromJson(json.decode(str));

String menuItemModelToJson(MenuItemResponseModel data) =>
    json.encode(data.toJson());

class MenuItemResponseModel {
  final MenuItemModel menuItemModel;
  const MenuItemResponseModel({required this.menuItemModel});

  factory MenuItemResponseModel.fromJson(Map<String, dynamic> json) {
    return MenuItemResponseModel(menuItemModel: json['menuItem']);
  }

  Map<String, dynamic> toJson() {
    return {"menuItem": menuItemModel};
  }
}
