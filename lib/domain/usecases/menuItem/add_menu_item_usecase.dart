import 'package:dartz/dartz.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/usecase/usecase.dart';
import 'package:foody_licious_admin_app/domain/repositories/menu_item_repository.dart';

class AddMenuItemUseCase implements UseCase<Unit, AddMenuItemParams> {
  final MenuItemRepository repository;
  AddMenuItemUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(params) {
    return repository.addItemInMenu(params);
  }
}

class AddMenuItemParams {
  String? restaurantId;
  final String name;
  final int price;
  final String? description;
  final int? availableQuantity;
  final List<String>? ingredients;

  AddMenuItemParams({
    this.restaurantId,
    required this.name,
    required this.price,
    this.description,
    this.availableQuantity = 0,
    this.ingredients = const ["ingredient1"],
  });
}
