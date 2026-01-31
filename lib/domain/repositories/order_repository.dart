import 'package:dartz/dartz.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/domain/entities/order/order.dart';
import 'package:foody_licious_admin_app/domain/usecases/order/get_all_order_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/order/update_order_status_usecase.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<OrderEntity>>> getAllOrders(GetAllOrdersParams params);
  Future<Either<Failure, OrderEntity>> updateOrderStatus(UpdateOrderStatusParams params);
}
