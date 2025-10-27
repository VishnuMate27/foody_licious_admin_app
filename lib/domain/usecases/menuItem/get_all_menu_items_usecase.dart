import 'package:dartz/dartz.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/usecase/usecase.dart';
import 'package:foody_licious_admin_app/domain/entities/menuItem/menuItem.dart';
import 'package:foody_licious_admin_app/domain/repositories/menu_item_repository.dart';

class GetAllMenuItemsUseCase implements UseCase<List<MenuItem>, NoParams> {
  final MenuItemRepository repository;

  GetAllMenuItemsUseCase(this.repository);
  @override
  Future<Either<Failure, List<MenuItem>>> call(void params) async {
    return await repository.getAllMenuItem();
  }
}
