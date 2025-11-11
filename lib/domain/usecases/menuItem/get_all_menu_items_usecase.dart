import 'package:dartz/dartz.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/usecase/usecase.dart';
import 'package:foody_licious_admin_app/domain/entities/menuItem/menuItem.dart';
import 'package:foody_licious_admin_app/domain/repositories/menu_item_repository.dart';

class GetAllMenuItemsUseCase
    implements UseCase<List<MenuItem>, GetAllMenuItemsParams> {
  final MenuItemRepository repository;

  GetAllMenuItemsUseCase(this.repository);
  @override
  Future<Either<Failure, List<MenuItem>>> call(
    GetAllMenuItemsParams params,
  ) async {
    return await repository.getAllMenuItem(params);
  }
}

class GetAllMenuItemsParams {
  String? restaurantId;
  int page;
  int limit;
  GetAllMenuItemsParams({
    this.restaurantId,
    required this.page,
    required this.limit,
  });
    Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (restaurantId != null) data['restaurantId'] = restaurantId;
    data['page'] = page;
    data['limit'] = limit; 
    return data;
  }
}
