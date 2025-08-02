import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          style: GoogleFonts.yeonSung(color: Color(0xFFE85353), fontSize: 40),
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
                    child: CartItemCard(
                      itemImageUrl: "assets/images/MenuPhoto1.png",
                      itemName: "Herbal Pancake",
                      restaurantName: "Warung Herbal",
                      itemPrice: 7,
                      itemQuantity: 1,
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

class CartItemCard extends StatefulWidget {
  final String itemImageUrl;
  final String itemName;
  final String restaurantName;
  final num itemPrice;
  final num itemQuantity;

  CartItemCard({
    super.key,
    required this.itemImageUrl,
    required this.itemName,
    required this.restaurantName,
    required this.itemPrice,
    required this.itemQuantity,
  });

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 87.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Color(0x51FF8080)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 10.w),
            Image.asset(widget.itemImageUrl, width: 64.h, height: 64.h),
            SizedBox(width: 20.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.itemName,
                    style: GoogleFonts.yeonSung(
                      color: Color(0xFF000000),
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    widget.restaurantName,
                    style: GoogleFonts.lato(
                      color: Color(0xFF3B3B3B),
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "\$ ${widget.itemPrice}",
                    style: GoogleFonts.lato(
                      color: Color(0xFFE85353),
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print("- button pressed");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFEBFBF2),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        width: 26.w,
                        height: 26.h,
                        child: const Icon(
                          CupertinoIcons.minus,
                          color: Color(0xFFD53737),
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      "${widget.itemQuantity}",
                      style: GoogleFonts.lato(
                        color: Color(0xFF181818),
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    GestureDetector(
                      onTap: () {
                        print("+ button pressed");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFD53737),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        width: 26.w,
                        height: 26.h,
                        child: const Icon(
                          CupertinoIcons.plus,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        print("Delete button pressed");
                      },
                      icon: Icon(
                        CupertinoIcons.delete,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(width: 10.w),
          ],
        ),
      ),
    );
  }
}
