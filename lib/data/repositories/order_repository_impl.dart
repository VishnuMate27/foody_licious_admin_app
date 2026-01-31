import 'package:dartz/dartz.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/network/network_info.dart';
import 'package:foody_licious_admin_app/data/data_sources/remote/order_remote_data_source.dart';
import 'package:foody_licious_admin_app/data/data_sources/local/restaurant_local_data_source.dart';
import 'package:foody_licious_admin_app/domain/entities/order/order.dart';
import 'package:foody_licious_admin_app/domain/repositories/order_repository.dart';
import 'package:foody_licious_admin_app/domain/usecases/order/get_all_order_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/order/update_order_status_usecase.dart';

class OrderRepositoryImpl extends OrderRepository {
  final OrderRemoteDataSource remoteDataSource;
  final RestaurantLocalDataSource restaurantLocalDataSource;
  final NetworkInfo networkInfo;
  OrderRepositoryImpl({
    required this.remoteDataSource,
    required this.restaurantLocalDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<OrderEntity>>> getAllOrders(
    GetAllOrdersParams params,
  ) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final restaurant = await restaurantLocalDataSource.getRestaurant();
      params.restaurantId = restaurant.id;
      final remoteResponse = await remoteDataSource.getAllOrders(params);
      return Right(remoteResponse.orders);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, OrderEntity>> updateOrderStatus(
    UpdateOrderStatusParams params,
  ) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final restaurant = await restaurantLocalDataSource.getRestaurant();
      params.restaurantId = restaurant.id;
      final remoteResponse = await remoteDataSource.updateOrderStatus(params);
      return Right(remoteResponse.orderResponseModel);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
