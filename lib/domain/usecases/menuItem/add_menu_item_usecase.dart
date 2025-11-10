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
  String? itemId;
  String? restaurantId;
  final String name;
  final int price;
  final String? description;
  final int? availableQuantity;
  final List<String>? imageFilePaths;
  final List<String>? ingredients;

  AddMenuItemParams({
    this.itemId,
    this.restaurantId,
    required this.name,
    required this.price,
    this.description,
    this.availableQuantity = 0,
    this.imageFilePaths,
    this.ingredients,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (itemId != null) data['itemId'] = itemId;
    if (restaurantId != null) data['restaurantId'] = restaurantId;
    if (name != null) data['name'] = name;
    if (price != null) data['price'] = price;
    if (description != null) data['description'] = description;
    if (availableQuantity != null) data['availableQuantity'] = availableQuantity;
    if (imageFilePaths != null) data['imageFilePaths'] = imageFilePaths;
    if (ingredients != null) data['ingredients'] = ingredients;  
    return data;
  }
}
