part of 'menu_item_bloc.dart';

abstract class MenuItemEvent {}

class AddMenuItem extends MenuItemEvent {
  final AddMenuItemParams params;
  AddMenuItem(this.params);
}

class DeleteMenuItem extends MenuItemEvent {
  final DeleteMenuItemParams params;
  DeleteMenuItem(this.params);
}

class GetAllMenuItems extends MenuItemEvent {}

class IncreaseItemQuantity extends MenuItemEvent {
  final IncreaseItemQuantityParams params;
  IncreaseItemQuantity(this.params);
}

class DecreaseItemQuantity extends MenuItemEvent {
  final DecreaseItemQuantityParams params;
  DecreaseItemQuantity(this.params);
}