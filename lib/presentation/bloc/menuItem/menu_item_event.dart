part of 'menu_item_bloc.dart';

@immutable
abstract class MenuItemEvent {}

class AddMenuItem extends MenuItemEvent {}

class DeleteMenuItem extends MenuItemEvent {}

class GetAllMenuItems extends MenuItemEvent {}

class IncreaseItemQuantity extends MenuItemEvent {}

class DecreaseItemQuantity extends MenuItemEvent {}
