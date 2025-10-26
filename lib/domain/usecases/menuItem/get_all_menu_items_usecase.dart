import 'package:dartz/dartz.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/usecase/usecase.dart';
import 'package:foody_licious_admin_app/data/models/menuItem/menu_items_response_model.dart';
import 'package:foody_licious_admin_app/domain/repositories/menu_item_repository.dart';

class GetAllMenuItemsUsecase
    implements UseCase<MenuItemsResponseModel, NoParams> {
  final MenuItemRepository repository;

  GetAllMenuItemsUsecase({required this.repository});  
  @override
  Future<Either<Failure, MenuItemsResponseModel>> call(void params) async {
    return await repository.getAllMenuItem();
  }
}
