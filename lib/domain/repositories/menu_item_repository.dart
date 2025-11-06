
import 'package:dartz/dartz.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/domain/entities/menuItem/menuItem.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/add_menu_item_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/delete_menu_item_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/update_menu_item_usecase.dart';

abstract class MenuItemRepository {
  Future<Either<Failure,Unit>> addItemInMenu(AddMenuItemParams params);
  Future<Either<Failure,MenuItem>> updateItemInMenu(UpdateMenuItemParams params);
  Future<Either<Failure,Unit>> deleteItemInMenu(DeleteMenuItemParams params);
  Future<Either<Failure,List<MenuItem>>> getAllMenuItem();
  Future<Either<Failure,MenuItem>> increaseItemQuantity(String itemId);
  Future<Either<Failure,MenuItem>> decreaseItemQuantity(String itemId);
}