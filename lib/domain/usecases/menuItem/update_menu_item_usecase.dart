import 'package:dartz/dartz.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/usecase/usecase.dart';
import 'package:foody_licious_admin_app/domain/entities/menuItem/menuItem.dart';
import 'package:foody_licious_admin_app/domain/repositories/menu_item_repository.dart';
import 'package:image_picker/image_picker.dart';

class UpdateMenuItemUseCase implements UseCase<MenuItem, UpdateMenuItemParams> {
  final MenuItemRepository repository;
  UpdateMenuItemUseCase(this.repository);

  @override
  Future<Either<Failure, MenuItem>> call(params) async {
    return repository.updateItemInMenu(params);
  }
}

class UpdateMenuItemParams {
  final String id;
  String? restaurantId;
  String? name;
  String? description;
  int? price;
  int? availableQuantity;
  List<String?>? images;
  List<String?>? ingredients;
  UpdateMenuItemParams({
    required this.id,
    this.restaurantId,
    this.name,
    this.description,
    this.price,
    this.availableQuantity,
    this.images,
    this.ingredients,
  });
}
