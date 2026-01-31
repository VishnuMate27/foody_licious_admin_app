import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:foody_licious_admin_app/core/constants/colors.dart';
import 'package:foody_licious_admin_app/core/extension/failure_extension.dart';
import 'package:foody_licious_admin_app/domain/entities/order/order.dart';
import 'package:foody_licious_admin_app/domain/usecases/order/get_all_order_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/order/update_order_status_usecase.dart';
import 'package:foody_licious_admin_app/presentation/bloc/order/order_bloc.dart';
import 'package:foody_licious_admin_app/presentation/cubit/pagination/pagination_cubit.dart';
import 'package:foody_licious_admin_app/presentation/widgets/order_card.dart';
import 'package:foody_licious_admin_app/presentation/widgets/tab_chip.dart';
import 'package:google_fonts/google_fonts.dart';

class ManageOrdersView extends StatefulWidget {
  const ManageOrdersView({super.key});

  @override
  State<ManageOrdersView> createState() => _ManageOrdersViewState();
}

class _ManageOrdersViewState extends State<ManageOrdersView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  final int _pageSize = 20;
  late final PaginationCubit _paginationCubit;

  @override
  void initState() {
    super.initState();
    _paginationCubit = PaginationCubit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // initial load
      context.read<OrderBloc>().add(
        GetAllOrdersByStatus(
          GetAllOrdersParams(
            page: 1,
            limit: _pageSize,
            statuses: [OrderStatus.CONFIRMED.name, OrderStatus.PREPARING.name],
          ),
        ),
      );
    });
    _scrollController.addListener(() {
      if (!_scrollController.hasClients) return;
      final max = _scrollController.position.maxScrollExtent;
      final current = _scrollController.position.pixels;
      // when within 200px of bottom, try load more
      if (current >= (max - 200)) {
        final pstate = _paginationCubit.state;
        if (!pstate.isLoadingMore && pstate.hasMoreItems) {
          _paginationCubit.loadMoreItems();
          // trigger fetching next page
          context.read<OrderBloc>().add(
            GetAllOrdersByStatus(
              GetAllOrdersParams(
                page: _paginationCubit.state.currentPage,
                limit: _pageSize,
                statuses: [
                  OrderStatus.CONFIRMED.name,
                  OrderStatus.PREPARING.name,
                ],
              ),
            ),
          );
        }
      }
    });
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderBloc, OrderState>(
      listenWhen:
          (previous, current) =>
              current is UpdateOrderStatusFailed ||
              current is UpdateOrderStatusSuccess ||
              current is GetAllOrdersByStatusFailed,
      listener: (context, state) {
        if (state is UpdateOrderStatusFailed) {
          EasyLoading.showError(
            state.failure.toMessage(
              defaultMessage: "Failed to Update Order status!",
            ),
          );
          context.read<OrderBloc>().add(
            GetAllOrdersByStatus(
              GetAllOrdersParams(
                page: 1,
                limit: _pageSize,
                statuses: [
                  OrderStatus.CONFIRMED.name,
                  OrderStatus.PREPARING.name,
                ],
              ),
            ),
          );
        } else if (state is UpdateOrderStatusSuccess) {
          EasyLoading.showSuccess("Order Status Updated Successfully!");
          context.read<OrderBloc>().add(
            GetAllOrdersByStatus(
              GetAllOrdersParams(
                page: 1,
                limit: _pageSize,
                statuses: [
                  OrderStatus.CONFIRMED.name,
                  OrderStatus.PREPARING.name,
                ],
              ),
            ),
          );
        } else if (state is GetAllOrdersByStatusFailed) {
          EasyLoading.showError(
            state.failure.toMessage(
              defaultMessage: "Failed to Get Order status.",
            ),
          );
        }
      },

      buildWhen:
          (previous, current) =>
              current is GetAllOrdersByStatusLoading ||
              current is GetAllOrdersByStatusSuccess ||
              current is GetAllOrdersByStatusFailed,
      builder: (context, state) {
        if (state is GetAllOrdersByStatusLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is GetAllOrdersByStatusSuccess) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Manage Orders",
                style: GoogleFonts.yeonSung(color: kTextRed, fontSize: 40),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset("assets/icons/back_arrow.png", color: kBlack),
              ),
              centerTitle: true,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(48),
                child: Padding(
                  padding: const EdgeInsets.only(left: 4), // tweak this value
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                    padding: EdgeInsets.zero,
                    dividerColor: Colors.transparent,
                    indicatorColor: Colors.transparent,
                    tabs: [
                      Tab(
                        child: TabChip(
                          tabName: "All",
                          tabItemLength: state.orders.length,
                          isTabSelected: _tabController.index == 0,
                        ),
                      ),
                      Tab(
                        child: TabChip(
                          tabName: "Confirmed",
                          tabItemLength:
                              state.orders
                                  .where(
                                    (orderEntity) =>
                                        orderEntity.status ==
                                        OrderStatus.CONFIRMED.name,
                                  )
                                  .length,
                          isTabSelected: _tabController.index == 1,
                        ),
                      ),
                      Tab(
                        child: TabChip(
                          tabName: "Preparing",
                          tabItemLength:
                              state.orders
                                  .where(
                                    (orderEntity) =>
                                        orderEntity.status ==
                                        OrderStatus.PREPARING.name,
                                  )
                                  .length,
                          isTabSelected: _tabController.index == 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: <Widget>[
                RefreshIndicator(
                  onRefresh: () async {
                    context.read<OrderBloc>().add(
                      GetAllOrdersByStatus(
                        GetAllOrdersParams(
                          page: 1,
                          limit: _pageSize,
                          statuses: [
                            OrderStatus.CONFIRMED.name,
                            OrderStatus.PREPARING.name,
                          ],
                        ),
                      ),
                    );
                  },
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller: _scrollController,
                    itemCount: state.orders.length,
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    itemBuilder: (context, index) {
                      final orderItem = state.orders[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: OrderCard.order(
                          orderId: orderItem.id,
                          orderCreatedAt: orderItem.createdAt,
                          orderStatus: orderItem.status,
                          items: orderItem.items,
                          price: orderItem.grandTotalAmount.toString(),
                          paymentMode: orderItem.paymentStatus,
                          paymentStatus: orderItem.paymentStatus,
                          customerName: orderItem.name,
                          customerAddress: orderItem.address,
                          customerPhone: orderItem.phone,
                          onMoreButtonTap: () {},
                          onAcceptTap: () {
                            // Update Status to Preparing
                            context.read<OrderBloc>().add(
                              UpdateOrderStatus(
                                UpdateOrderStatusParams(
                                  orderId: orderItem.id,
                                  status: OrderStatus.PREPARING.name,
                                ),
                              ),
                            );
                          },
                          onRejectTap: () {
                            // Update Status to CANCELED
                            showDialog(
                              context: context,
                              builder: (dialogContext) {
                                return AlertDialog(
                                  title: Text("Cancel Order?"),
                                  content: Text(
                                    "Are you sure to cancel this order? Once marked cancelled this action cannot be reverted.",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(dialogContext).pop();
                                      },
                                      child: Text("No"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        context.read<OrderBloc>().add(
                                          UpdateOrderStatus(
                                            UpdateOrderStatusParams(
                                              orderId: orderItem.id,
                                              status:
                                                  OrderStatus
                                                      .CANCELLED_BY_RESTAURANT
                                                      .name,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text("Yes"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          onMarkAsDispatchedTap: () {
                            // Update Status to DISPATCHED
                            context.read<OrderBloc>().add(
                              UpdateOrderStatus(
                                UpdateOrderStatusParams(
                                  orderId: orderItem.id,
                                  status: OrderStatus.DISPATCHED.name,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                RefreshIndicator(
                  onRefresh: () async {
                    context.read<OrderBloc>().add(
                      GetAllOrdersByStatus(
                        GetAllOrdersParams(
                          page: 1,
                          limit: _pageSize,
                          statuses: [
                            OrderStatus.CONFIRMED.name,
                            OrderStatus.PREPARING.name,
                          ],
                        ),
                      ),
                    );
                  },
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller: _scrollController,
                    itemCount: state.orders.length,
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    itemBuilder: (context, index) {
                      final orderItem = state.orders[index];
                      if (orderItem.status == OrderStatus.CONFIRMED.name) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: OrderCard.order(
                            orderId: orderItem.id,
                            orderCreatedAt: orderItem.createdAt,
                            orderStatus: orderItem.status,
                            items: orderItem.items,
                            price: orderItem.grandTotalAmount.toString(),
                            paymentMode: orderItem.paymentStatus,
                            paymentStatus: orderItem.paymentStatus,
                            customerName: orderItem.name,
                            customerAddress: orderItem.address,
                            customerPhone: orderItem.phone,
                            onMoreButtonTap: () {},
                            onAcceptTap: () {
                              // Update Status to PREPARING
                              context.read<OrderBloc>().add(
                                UpdateOrderStatus(
                                  UpdateOrderStatusParams(
                                    orderId: orderItem.id,
                                    status: OrderStatus.PREPARING.name,
                                  ),
                                ),
                              );
                            },
                            onRejectTap: () {
                              // Update Status to CANCELED
                              showDialog(
                                context: context,
                                builder: (dialogContext) {
                                  return AlertDialog(
                                    title: Text("Cancel Order?"),
                                    content: Text(
                                      "Are you sure to cancel this order? Once marked cancelled this action cannot be reverted.",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(dialogContext).pop();
                                        },
                                        child: Text("No"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          context.read<OrderBloc>().add(
                                            UpdateOrderStatus(
                                              UpdateOrderStatusParams(
                                                orderId: orderItem.id,
                                                status:
                                                    OrderStatus
                                                        .CANCELLED_BY_RESTAURANT
                                                        .name,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text("Yes"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            onMarkAsDispatchedTap: () {
                              // Update Status to DISPATCHED
                              context.read<OrderBloc>().add(
                                UpdateOrderStatus(
                                  UpdateOrderStatusParams(
                                    orderId: orderItem.id,
                                    status: OrderStatus.DISPATCHED.name,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
                RefreshIndicator(
                  onRefresh: () async {
                    context.read<OrderBloc>().add(
                      GetAllOrdersByStatus(
                        GetAllOrdersParams(
                          page: 1,
                          limit: _pageSize,
                          statuses: [
                            OrderStatus.CONFIRMED.name,
                            OrderStatus.PREPARING.name,
                          ],
                        ),
                      ),
                    );
                  },
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller: _scrollController,
                    itemCount: state.orders.length,
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    itemBuilder: (context, index) {
                      final orderItem = state.orders[index];
                      if (orderItem.status == OrderStatus.PREPARING.name) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: OrderCard.order(
                            orderId: orderItem.id,
                            orderCreatedAt: orderItem.createdAt,
                            orderStatus: orderItem.status,
                            items: orderItem.items,
                            price: orderItem.grandTotalAmount.toString(),
                            paymentMode: orderItem.paymentStatus,
                            paymentStatus: orderItem.paymentStatus,
                            customerName: orderItem.name,
                            customerAddress: orderItem.address,
                            customerPhone: orderItem.phone,
                            onMoreButtonTap: () {},
                            onAcceptTap: () {
                              // Update Status to Preparing
                              context.read<OrderBloc>().add(
                                UpdateOrderStatus(
                                  UpdateOrderStatusParams(
                                    orderId: orderItem.id,
                                    status: OrderStatus.PREPARING.name,
                                  ),
                                ),
                              );
                            },
                            onRejectTap: () {
                              // Update Status to CANCELED
                              showDialog(
                                context: context,
                                builder: (dialogContext) {
                                  return AlertDialog(
                                    title: Text("Cancel Order?"),
                                    content: Text(
                                      "Are you sure to cancel this order? Once marked cancelled this action cannot be reverted.",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(dialogContext).pop();
                                        },
                                        child: Text("No"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          context.read<OrderBloc>().add(
                                            UpdateOrderStatus(
                                              UpdateOrderStatusParams(
                                                orderId: orderItem.id,
                                                status:
                                                    OrderStatus
                                                        .CANCELLED_BY_RESTAURANT
                                                        .name,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text("Yes"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            onMarkAsDispatchedTap: () {
                              // Update Status to DISPATCHED
                              context.read<OrderBloc>().add(
                                UpdateOrderStatus(
                                  UpdateOrderStatusParams(
                                    orderId: orderItem.id,
                                    status: OrderStatus.DISPATCHED.name,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (state is GetAllOrdersByStatusFailed) {
          return Center(child: Text("Failed to fetch Orders."));
        } else {
          return Center(child: Text("state is $state"));
        }
      },
    );
  }
}
