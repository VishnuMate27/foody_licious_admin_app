import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious_admin_app/core/constants/colors.dart';
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
          "All Item",
          style: GoogleFonts.yeonSung(color: kTextRed, fontSize: 40),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: BlocConsumer<MenuItemBloc, MenuItemState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is FetchingAllMenuItemsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FetchingAllMenuItemsSuccess) {
              return ListView.builder(
                itemCount: state.menuItems.length,
                padding: EdgeInsets.symmetric(vertical: 20.h),
                itemBuilder: (BuildContext context, int index) {
                  final menuItem = state.menuItems[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: MenuItemCard.cartItem(
                      itemImageUrl:
                          (menuItem.images!.isNotEmpty) ? menuItem.images!.first:
                          "https://img.freepik.com/free-psd/hand-drawn-burger-illustration_23-2151600206.jpg?semt=ais_hybrid&w=740&q=80",
                      itemName: menuItem.name,
                      hotelName: menuItem.name,
                      itemPrice: menuItem.price,
                      itemQuantity: menuItem.availableQuantity,
                      onIncreaseItemButtonPressed:() {
                        
                      },
                      onDecreaseItemButtonPressed: () {
                        
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
              return Center(child: Text("Failed to load items"));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
