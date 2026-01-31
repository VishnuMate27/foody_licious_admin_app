part of 'order_bloc.dart';

abstract class OrderState extends Equatable {}

class OrderInitial extends OrderState {
  @override
  List<Object> get props => [];
}

class GetAllOrdersByStatusLoading extends OrderState {
  @override
  List<Object> get props => [];
}

class GetAllOrdersByStatusSuccess extends OrderState {
  final List<OrderEntity> orders;
  GetAllOrdersByStatusSuccess(this.orders);
  @override
  List<Object> get props => [orders];
}

class GetAllOrdersByStatusFailed extends OrderState {
  final Failure failure;
  GetAllOrdersByStatusFailed(this.failure);
  @override
  List<Object> get props => [failure];
}


class UpdateOrderStatusLoading extends OrderState {
  @override
  List<Object> get props => [];
}

class UpdateOrderStatusSuccess extends OrderState {
  final OrderEntity order;
  UpdateOrderStatusSuccess(this.order);
  @override
  List<Object> get props => [order];
}

class UpdateOrderStatusFailed extends OrderState {
  final Failure failure;
  UpdateOrderStatusFailed(this.failure);
  @override
  List<Object> get props => [failure];
}
