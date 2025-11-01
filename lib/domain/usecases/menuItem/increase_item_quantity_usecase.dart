import 'package:dartz/dartz.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/usecase/usecase.dart';
import 'package:foody_licious_admin_app/domain/entities/menuItem/menuItem.dart';
import 'package:foody_licious_admin_app/domain/repositories/menu_item_repository.dart';

class IncreaseItemQuantityUseCase
    implements UseCase<MenuItem, IncreaseItemQuantityParams> {
  final MenuItemRepository repository;
  IncreaseItemQuantityUseCase(this.repository);

  @override
  Future<Either<Failure, MenuItem>> call(params) async {
    return await repository.increaseItemQuantity(params.itemId);
  }
}

class IncreaseItemQuantityParams {
  final String itemId;
  IncreaseItemQuantityParams({required this.itemId});
}
