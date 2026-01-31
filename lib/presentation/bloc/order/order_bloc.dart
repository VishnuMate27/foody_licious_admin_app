import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/domain/entities/order/order.dart';
import 'package:foody_licious_admin_app/domain/usecases/order/get_all_order_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/order/update_order_status_usecase.dart';
part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetAllOrderUseCase getAllOrderUseCase;
  final UpdateOrderUseCase updateOrderUseCase;
  OrderBloc(this.getAllOrderUseCase, this.updateOrderUseCase)
    : super(OrderInitial()) {
    {
      on<GetAllOrdersByStatus>(_onGetAllOrdersByStatus);
      on<UpdateOrderStatus>(_onUpdateOrderStatus);
    }
  }

  void _onGetAllOrdersByStatus(
    GetAllOrdersByStatus event,
    Emitter<OrderState> emit,
  ) async {
    try {
      // Only show loading for first page
      if (event.params.page == 1) {
        emit(GetAllOrdersByStatusLoading());
      }
      final result = await getAllOrderUseCase(event.params);
      result.fold((failure) => emit(GetAllOrdersByStatusFailed(failure)), (
        newOrders,
      ) {
        final currentState = state;
        if (currentState is GetAllOrdersByStatusSuccess) {
          final updatedList =
              event.params.page == 1
                  ? newOrders
                  : [...currentState.orders, ...newOrders];
          emit(GetAllOrdersByStatusSuccess(updatedList));
        } else {
          emit(GetAllOrdersByStatusSuccess(newOrders));
        }
      });
    } catch (e, stacktrace) {
      print("GetAllOrdersByStatusFailed: $e, \n Stacktrace:$stacktrace");
      emit(GetAllOrdersByStatusFailed(ExceptionFailure(e.toString())));
    }
  }

  void _onUpdateOrderStatus(
    UpdateOrderStatus event,
    Emitter<OrderState> emit,
  ) async {
    try {
      emit(UpdateOrderStatusLoading());
      final result = await updateOrderUseCase(event.params);
      result.fold(
        (failure) => emit(UpdateOrderStatusFailed(failure)),
        (orders) => emit(UpdateOrderStatusSuccess(orders)),
      );
    } catch (e) {
      emit(UpdateOrderStatusFailed(ExceptionFailure(e.toString())));
    }
  }
}
