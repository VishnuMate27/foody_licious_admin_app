part of 'order_bloc.dart';

abstract class OrderEvent {}

class GetAllOrdersByStatus extends OrderEvent {
  GetAllOrdersParams params;
  GetAllOrdersByStatus(this.params);
}

class UpdateOrderStatus  extends OrderEvent {
  UpdateOrderStatusParams params;
  UpdateOrderStatus(this.params);
}
