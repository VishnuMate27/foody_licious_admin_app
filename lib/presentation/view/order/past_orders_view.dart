import 'package:flutter/material.dart';
import 'package:foody_licious_admin_app/domain/usecases/order/get_all_order_usecase.dart';
import 'package:foody_licious_admin_app/presentation/bloc/order/order_bloc.dart';
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

class PastOrdersView extends StatefulWidget {
  const PastOrdersView({super.key});
  @override
  State<PastOrdersView> createState() => _PastOrdersViewState();
}

class _PastOrdersViewState extends State<PastOrdersView>
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
            statuses: [
              OrderStatus.DELIVERED.name,
              OrderStatus.CANCELLED_BY_RESTAURANT.name,
            ],
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
                  OrderStatus.CANCELLED_BY_RESTAURANT.name,
                  OrderStatus.DELIVERED.name,
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
                  OrderStatus.CANCELLED_BY_RESTAURANT.name,
                  OrderStatus.DELIVERED.name,
                ],
              ),
            ),
          );
        } else if (state is UpdateOrderStatusSuccess) {
          context.read<OrderBloc>().add(
            GetAllOrdersByStatus(
              GetAllOrdersParams(
                page: 1,
                limit: _pageSize,
                statuses: [
                  OrderStatus.CANCELLED_BY_RESTAURANT.name,
                  OrderStatus.DELIVERED.name,
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
      listenWhen:
          (previous, current) =>
              current is UpdateOrderStatusFailed ||
              current is UpdateOrderStatusSuccess ||
              current is GetAllOrdersByStatusFailed,
      builder: (context, state) {
        if (state is GetAllOrdersByStatusLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is GetAllOrdersByStatusSuccess) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Past Orders",
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
                          tabName: "Delivered",
                          tabItemLength:
                              state.orders
                                  .where(
                                    (orderEntity) =>
                                        orderEntity.status ==
                                        OrderStatus.DELIVERED.name,
                                  )
                                  .length,
                          isTabSelected: _tabController.index == 1,
                        ),
                      ),
                      Tab(
                        child: TabChip(
                          tabName: "Cancelled",
                          tabItemLength:
                              state.orders
                                  .where(
                                    (orderEntity) =>
                                        orderEntity.status ==
                                        OrderStatus
                                            .CANCELLED_BY_RESTAURANT
                                            .name,
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
                            OrderStatus.DELIVERED.name,
                            OrderStatus.CANCELLED_BY_RESTAURANT.name,
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
                        child: OrderCard.pastOrder(
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
                            OrderStatus.DELIVERED.name,
                            OrderStatus.CANCELLED_BY_RESTAURANT.name,
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
                      if (orderItem.status == OrderStatus.DELIVERED.name) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: OrderCard.pastOrder(
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
                            OrderStatus.DELIVERED.name,
                            OrderStatus.CANCELLED_BY_RESTAURANT.name,
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
                      if (orderItem.status ==
                          OrderStatus.CANCELLED_BY_RESTAURANT.name) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: OrderCard.pastOrder(
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
                          ),
                        );
                      } else {
                        return SizedBox.shrink();
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
