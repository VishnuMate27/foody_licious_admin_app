import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious_admin_app/core/constants/colors.dart';
import 'package:foody_licious_admin_app/core/router/app_router.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/decrease_item_quantity_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/delete_menu_item_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/get_all_menu_items_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/increase_item_quantity_usecase.dart';
import 'package:foody_licious_admin_app/presentation/bloc/menuItem/menu_item_bloc.dart';
import 'package:foody_licious_admin_app/presentation/widgets/menu_item_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foody_licious_admin_app/presentation/cubit/pagination/pagination_cubit.dart';

class AllMenuView extends StatefulWidget {
  const AllMenuView({super.key});

  @override
  State<AllMenuView> createState() => _AllMenuViewState();
}

class _AllMenuViewState extends State<AllMenuView> {
  final ScrollController _scrollController = ScrollController();
  final int _pageSize = 10;
  late final PaginationCubit _paginationCubit;

  @override
  void initState() {
    super.initState();
    _paginationCubit = PaginationCubit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // initial load
      context.read<MenuItemBloc>().add(
        GetAllMenuItems(GetAllMenuItemsParams(page: 1, limit: _pageSize)),
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
          context.read<MenuItemBloc>().add(
            GetAllMenuItems(
              GetAllMenuItemsParams(
                page: _paginationCubit.state.currentPage,
                limit: _pageSize,
              ),
            ),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _paginationCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _paginationCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "All Items",
            style: GoogleFonts.yeonSung(color: kTextRed, fontSize: 40),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: BlocConsumer<MenuItemBloc, MenuItemState>(
            listenWhen:
                (previous, current) =>
                    current is IncreaseMenuItemQuantityFailed ||
                    current is DecreaseMenuItemQuantityFailed ||
                    current is MenuItemDeleteFailed ||
                    current is MenuItemDeleteSuccess ||
                    current is FetchingAllMenuItemsSuccess,
            listener: (context, state) {
              if (state is IncreaseMenuItemQuantityFailed ||
                  state is DecreaseMenuItemQuantityFailed) {
                EasyLoading.showError("Failed to update item quantity");
              } else if (state is MenuItemDeleteSuccess) {
                EasyLoading.showSuccess("Menu Item Deleted Successfully!");
              } else if (state is MenuItemDeleteFailed) {
                EasyLoading.showError("Failed to delete item!");
              } else if (state is FetchingAllMenuItemsSuccess) {
                // determine whether there are more items based on page size
                // if totalItems >= currentPage * pageSize => probably has more
                final currentPage = _paginationCubit.state.currentPage;
                final totalItems = state.menuItems.length;
                final hasMore = totalItems >= (currentPage * _pageSize);
                _paginationCubit.setHasMoreItems(hasMore);
                // stop loadingMore flag (if any)
                if (_paginationCubit.state.isLoadingMore) {
                  // ensure isLoadingMore reset; setHasMoreItems already resets isLoadingMore=false
                  // no-op here
                }
              }
            },
            buildWhen: (previous, current) {
              // Allow rebuilds for these specific states
              return current is FetchingAllMenuItemsSuccess ||
                  current is FetchingAllMenuItemsLoading ||
                  current is FetchingAllMenuItemsFailed;
            },
            builder: (context, state) {
              if (state is FetchingAllMenuItemsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FetchingAllMenuItemsSuccess) {
                return BlocBuilder<PaginationCubit, PaginationState>(
                  builder: (context, pState) {
                    final showLoader = pState.isLoadingMore;
                    final itemCount =
                        state.menuItems.length + (showLoader ? 1 : 0);
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: itemCount,
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      itemBuilder: (context, index) {
                        if (index >= state.menuItems.length) {
                          // bottom loader
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        final menuItem = state.menuItems[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: MenuItemCard.cartItem(
                            key: ValueKey(menuItem.id),
                            itemImageUrl:
                                (menuItem.images?.isNotEmpty ?? false)
                                    ? menuItem.images!.first
                                    : "https://img.freepik.com/free-psd/hand-drawn-burger-illustration_23-2151600206.jpg",
                            itemName: menuItem.name,
                            description: menuItem.description!,
                            itemPrice: menuItem.price,
                            itemQuantity: menuItem.availableQuantity,
                            onIncreaseItemButtonPressed: () {
                              context.read<MenuItemBloc>().add(
                                IncreaseItemQuantity(
                                  IncreaseItemQuantityParams(
                                    itemId: menuItem.id,
                                  ),
                                ),
                              );
                            },
                            onDecreaseItemButtonPressed: () {
                              context.read<MenuItemBloc>().add(
                                DecreaseItemQuantity(
                                  DecreaseItemQuantityParams(
                                    itemId: menuItem.id,
                                  ),
                                ),
                              );
                            },
                            onDeleteButtonPressed: () {
                              context.read<MenuItemBloc>().add(
                                DeleteMenuItem(
                                  DeleteMenuItemParams(itemId: menuItem.id),
                                ),
                              );
                            },
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRouter.menuItemDetails,
                                arguments: {'menuItem': menuItem},
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                );
              } else if (state is FetchingAllMenuItemsFailed) {
                return const Center(child: Text("Failed to load items"));
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
