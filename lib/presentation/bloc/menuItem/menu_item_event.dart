part of 'menu_item_bloc.dart';

abstract class MenuItemEvent {}

class AddMenuItem extends MenuItemEvent {
  final AddMenuItemParams params;
  AddMenuItem(this.params);
}

class UpdateMenuItem extends MenuItemEvent {
  final UpdateMenuItemParams params;
  UpdateMenuItem(this.params);
}

class DeleteMenuItem extends MenuItemEvent {
  final DeleteMenuItemParams params;
  DeleteMenuItem(this.params);
}

class GetAllMenuItems extends MenuItemEvent {
  final GetAllMenuItemsParams params;
  GetAllMenuItems(this.params);
}

class IncreaseItemQuantity extends MenuItemEvent {
  final IncreaseItemQuantityParams params;
  IncreaseItemQuantity(this.params);
}

class DecreaseItemQuantity extends MenuItemEvent {
  final DecreaseItemQuantityParams params;
  DecreaseItemQuantity(this.params);
}
