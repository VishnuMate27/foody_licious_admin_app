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
  @override
  List<Object?> get props => [];
}

/// FetchingAllMenuItems
class FetchingAllMenuItemsLoading extends MenuItemState {
  @override
  List<Object?> get props => [];
}

class FetchingAllMenuItemsSuccess extends MenuItemState {
  @override
  List<Object?> get props => [];
}

class FetchingAllMenuItemsFailed extends MenuItemState {
  @override
  List<Object?> get props => [];
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
  @override
  List<Object?> get props => [];
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
  @override
  List<Object?> get props => [];
}
