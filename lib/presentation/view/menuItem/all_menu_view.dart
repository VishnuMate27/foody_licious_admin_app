import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious_admin_app/core/constants/colors.dart';
import 'package:foody_licious_admin_app/core/constants/images.dart';
import 'package:foody_licious_admin_app/presentation/widgets/menu_item_card.dart';
import 'package:google_fonts/google_fonts.dart';

class AllMenuView extends StatefulWidget {
  const AllMenuView({super.key});

  @override
  State<AllMenuView> createState() => _AllMenuViewState();
}

class _AllMenuViewState extends State<AllMenuView> {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: MenuItemCard.cartItem(
                      itemImageUrl: kMenuPhoto1,
                      itemName: "Herbal Pancake",
                      hotelName: "Warung Herbal",
                      itemPrice: 7,
                      itemQuantity: 1,
                      onDeleteButtonPressed: () {
                        debugPrint("Delete button tapped");
                      },
                      onTap: () {},
                    ),
                  );
                },
              ),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }
}
