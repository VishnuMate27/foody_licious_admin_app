import 'package:dartz/dartz.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/usecase/usecase.dart';
import 'package:foody_licious_admin_app/domain/entities/order/order.dart';
import 'package:foody_licious_admin_app/domain/repositories/order_repository.dart';

class UpdateOrderUseCase extends UseCase<OrderEntity, UpdateOrderStatusParams> {
  final OrderRepository repository;
  UpdateOrderUseCase(this.repository);
  @override
  Future<Either<Failure, OrderEntity>> call(UpdateOrderStatusParams params) {
    return repository.updateOrderStatus(params);
  }
}

class UpdateOrderStatusParams {
  final String orderId;
  final String status;
  String? restaurantId;
  UpdateOrderStatusParams({
    required this.orderId,
    required this.status,
    this.restaurantId,
  });
}
