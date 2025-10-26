import 'package:dartz/dartz.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/usecase/usecase.dart';
import 'package:foody_licious_admin_app/domain/repositories/menu_item_repository.dart';

class DeleteMenuItemUsecase implements UseCase<Unit, DeleteMenuItemParams> {
  final MenuItemRepository repository;  

  DeleteMenuItemUsecase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(params) {
    return repository.deleteItemInMenu(params);
  }
}

class DeleteMenuItemParams {
  final String? itemId;
  final String? restaurantId;
  final String? name;

  DeleteMenuItemParams({this.itemId, this.restaurantId, this.name});
}
