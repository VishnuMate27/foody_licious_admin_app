import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious_admin_app/core/constants/colors.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/decrease_item_quantity_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/increase_item_quantity_usecase.dart';
import 'package:foody_licious_admin_app/presentation/bloc/menuItem/menu_item_bloc.dart';
import 'package:foody_licious_admin_app/presentation/widgets/menu_item_card.dart';
import 'package:google_fonts/google_fonts.dart';

class AllMenuView extends StatefulWidget {
  const AllMenuView({super.key});

  @override
  State<AllMenuView> createState() => _AllMenuViewState();
}

class _AllMenuViewState extends State<AllMenuView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MenuItemBloc>().add(GetAllMenuItems());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  current is DecreaseMenuItemQuantityFailed,
          listener: (context, state) {
            if (state is IncreaseMenuItemQuantityFailed ||
                state is DecreaseMenuItemQuantityFailed) {
              EasyLoading.showError("Failed to update item quantity");
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
              return ListView.builder(
                itemCount: state.menuItems.length,
                padding: EdgeInsets.symmetric(vertical: 20.h),
                itemBuilder: (context, index) {
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
                            IncreaseItemQuantityParams(itemId: menuItem.id),
                          ),
                        );
                      },
                      onDecreaseItemButtonPressed: () {
                        context.read<MenuItemBloc>().add(
                          DecreaseItemQuantity(
                            DecreaseItemQuantityParams(itemId: menuItem.id),
                          ),
                        );
                      },
                      onDeleteButtonPressed: () {
                        debugPrint("Delete button tapped");
                      },
                      onTap: () {},
                    ),
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
    );
  }
}
