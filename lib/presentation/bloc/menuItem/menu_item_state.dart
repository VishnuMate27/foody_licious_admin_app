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
/// IncreaseMenuItemQuantityLoading & IncreaseMenuItemQuantitySuccess are not required
/// Because The principle: “UI rebuilds should be driven by meaningful state”
/// In a well-architected BLoC:
class IncreaseMenuItemQuantityFailed extends MenuItemState {
  final Failure failure;
  IncreaseMenuItemQuantityFailed(this.failure);
  @override
  List<Object?> get props => [failure];
}

/// DecreaseMenuItemQuantity
/// DecreaseMenuItemQuantityLoading & DecreaseMenuItemQuantitySuccess are not required
/// Because The principle: “UI rebuilds should be driven by meaningful state”

class DecreaseMenuItemQuantityFailed extends MenuItemState {
  final Failure failure;
  DecreaseMenuItemQuantityFailed(this.failure);
  @override
  List<Object?> get props => [failure];
}
