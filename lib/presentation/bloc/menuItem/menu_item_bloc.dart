import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/domain/entities/menuItem/menuItem.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/add_menu_item_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/decrease_item_quantity_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/delete_menu_item_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/get_all_menu_items_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/increase_item_quantity_usecase.dart';
part 'menu_item_state.dart';
part 'menu_item_event.dart';

class MenuItemBloc extends Bloc<MenuItemEvent, MenuItemState> {
  final AddMenuItemUseCase _addMenuItemUsecase;
  final DeleteMenuItemUseCase _deleteMenuItemUsecase;
  final GetAllMenuItemsUseCase _getAllMenuItemsUsecase;
  final IncreaseItemQuantityUseCase _increaseItemQuantityUsecase;
  final DecreaseItemQuantityUseCase _decreaseItemQuantityUsecase;
  MenuItemBloc(
    this._addMenuItemUsecase,
    this._deleteMenuItemUsecase,
    this._getAllMenuItemsUsecase,
    this._increaseItemQuantityUsecase,
    this._decreaseItemQuantityUsecase,
  ) : super(MenuItemInitial()) {
    {
      on<AddMenuItem>(_onAddMenuItem);
      on<DeleteMenuItem>(_onDeleteMenuItem);
      on<GetAllMenuItems>(_onGetAllMenuItems);
      on<IncreaseItemQuantity>(_onIncreaseItemQuantity);
      on<DecreaseItemQuantity>(_onDecreaseItemQuantity);
    }
  }

  FutureOr<void> _onAddMenuItem(
    AddMenuItem event,
    Emitter<MenuItemState> emit,
  ) async {
    try {
      emit(MenuItemAddLoading());
      final result = await _addMenuItemUsecase(event.params);
      result.fold(
        (failure) => emit(MenuItemAddFailed(failure)),
        (unit) => emit(MenuItemAddSuccess()),
      );
    } catch (e) {
      emit(MenuItemAddFailed(ExceptionFailure(e.toString())));
    }
  }

  FutureOr<void> _onDeleteMenuItem(
    DeleteMenuItem event,
    Emitter<MenuItemState> emit,
  ) async {
    try {
      emit(MenuItemDeleteLoading());
      final result = await _deleteMenuItemUsecase(event.params);
      result.fold(
        (failure) => emit(MenuItemDeleteFailed(failure)),
        (unit) => emit(MenuItemDeleteSuccess()),
      );
    } catch (e) {
      emit(MenuItemDeleteFailed(ExceptionFailure(e.toString())));
    }
  }

  FutureOr<void> _onGetAllMenuItems(
    GetAllMenuItems event,
    Emitter<MenuItemState> emit,
  ) async {
    try {
      emit(FetchingAllMenuItemsLoading());
      final result = await _getAllMenuItemsUsecase(event);
      result.fold(
        (failure) => emit(FetchingAllMenuItemsFailed(failure)),
        (menuItems) => emit(FetchingAllMenuItemsSuccess(menuItems)),
      );
    } catch (e) {
      emit(FetchingAllMenuItemsFailed(ExceptionFailure(e.toString())));
    }
  }

  FutureOr<void> _onIncreaseItemQuantity(
    IncreaseItemQuantity event,
    Emitter<MenuItemState> emit,
  ) async {
    try {
      emit(IncreaseMenuItemQuantityLoading());
      final result = await _increaseItemQuantityUsecase(event.params);
      result.fold(
        (failure) => emit(IncreaseMenuItemQuantityFailed(failure)),
        (unit) => emit(IncreaseMenuItemQuantitySuccess()),
      );
    } catch (e) {
      emit(IncreaseMenuItemQuantityFailed(ExceptionFailure(e.toString())));
    }
  }

  FutureOr<void> _onDecreaseItemQuantity(
    DecreaseItemQuantity event,
    Emitter<MenuItemState> emit,
  ) async {
    try {
      emit(DecreaseMenuItemQuantityLoading());
      final result = await _decreaseItemQuantityUsecase(event.params);
      result.fold(
        (failure) => emit(DecreaseMenuItemQuantityFailed(failure)),
        (unit) => emit(DecreaseMenuItemQuantitySuccess()),
      );
    } catch (e) {
      emit(DecreaseMenuItemQuantityFailed(ExceptionFailure(e.toString())));
    }
  }
}
