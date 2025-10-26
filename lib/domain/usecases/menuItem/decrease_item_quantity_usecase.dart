import 'package:dartz/dartz.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/usecase/usecase.dart';
import 'package:foody_licious_admin_app/domain/repositories/menu_item_repository.dart';

class DecreaseItemQuantityUsecase
    implements UseCase<Unit, DecreaseItemQuantityParams> {
  final MenuItemRepository repository;
  DecreaseItemQuantityUsecase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(params) async {
    return await repository.decreaseItemQuantity(params.itemId);
  }
}

class DecreaseItemQuantityParams {
  final String itemId;
  DecreaseItemQuantityParams({required this.itemId});
}