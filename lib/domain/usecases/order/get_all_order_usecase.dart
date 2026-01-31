import 'package:dartz/dartz.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/usecase/usecase.dart';
import 'package:foody_licious_admin_app/domain/entities/order/order.dart';
import 'package:foody_licious_admin_app/domain/repositories/order_repository.dart';

class GetAllOrderUseCase
    extends UseCase<List<OrderEntity>, GetAllOrdersParams> {
  final OrderRepository repository;
  GetAllOrderUseCase(this.repository);

  @override
  Future<Either<Failure, List<OrderEntity>>> call(GetAllOrdersParams params) {
    return repository.getAllOrders(params);
  }
}

class GetAllOrdersParams {
  String? restaurantId;
  int? page;
  int? limit;
  List<String>? statuses;
  GetAllOrdersParams({this.restaurantId, this.page, this.limit, this.statuses});
}
