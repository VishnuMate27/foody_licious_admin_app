part of 'menu_item_bloc.dart';

abstract class MenuItemState extends Equatable {}

class MenuItemInitial extends MenuItemState {
  @override
  List<Object?> get props => [];
}

/// MenuItemAdd
class MenuItemAddLoading extends MenuItemState {
  @override
  List<Object?> get props => [];
}

class MenuItemAddSuccess extends MenuItemState {
  @override
  List<Object?> get props => [];
}

class MenuItemAddFailed extends MenuItemState {
  final Failure failure;
  MenuItemAddFailed(this.failure);
  @override
  List<Object?> get props => [];
}

/// MenuItemDelete
class MenuItemDeleteLoading extends MenuItemState {
  @override
  List<Object?> get props => [];
}

class MenuItemDeleteSuccess extends MenuItemState {
  @override
  List<Object?> get props => [];
}

class MenuItemDeleteFailed extends MenuItemState {
  final Failure failure;
  MenuItemDeleteFailed(this.failure);
  @override
  List<Object?> get props => [failure];
}

/// FetchingAllMenuItems
class FetchingAllMenuItemsLoading extends MenuItemState {
  @override
  List<Object?> get props => [];
}

class FetchingAllMenuItemsSuccess extends MenuItemState {
  final List<MenuItem> menuItems;
  FetchingAllMenuItemsSuccess(this.menuItems);
  @override
  List<Object?> get props => [menuItems];
}

class FetchingAllMenuItemsFailed extends MenuItemState {
  final Failure failure;
  FetchingAllMenuItemsFailed(this.failure);
  @override
  List<Object?> get props => [failure];
}

/// IncreaseMenuItemQuantity
class IncreaseMenuItemQuantityLoading extends MenuItemState {
  @override
  List<Object?> get props => [];
}

class IncreaseMenuItemQuantitySuccess extends MenuItemState {
  @override
  List<Object?> get props => [];
}

class IncreaseMenuItemQuantityFailed extends MenuItemState {
  final Failure failure;
  IncreaseMenuItemQuantityFailed(this.failure);
  @override
  List<Object?> get props => [failure];
}

/// DecreaseMenuItemQuantity
class DecreaseMenuItemQuantityLoading extends MenuItemState {
  @override
  List<Object?> get props => [];
}

class DecreaseMenuItemQuantitySuccess extends MenuItemState {
  @override
  List<Object?> get props => [];
}

class DecreaseMenuItemQuantityFailed extends MenuItemState {
  final Failure failure;
  DecreaseMenuItemQuantityFailed(this.failure);
  @override
  List<Object?> get props => [failure];
}
