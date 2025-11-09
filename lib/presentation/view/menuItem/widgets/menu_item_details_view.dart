import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious_admin_app/presentation/widgets/gradient_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foody_licious_admin_app/core/constants/colors.dart';
import 'package:foody_licious_admin_app/core/constants/images.dart';
import 'package:foody_licious_admin_app/presentation/cubit/menuItem/menu_item_form_cubit.dart';
import 'package:foody_licious_admin_app/domain/entities/menuItem/menuItem.dart';

class MenuItemDetailsWidget extends StatelessWidget {
  final MenuItem menuItem;

  const MenuItemDetailsWidget({super.key, required this.menuItem});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MenuItemFormCubit>();
    final currentMenuItem = context.select(
      (MenuItemFormCubit c) =>
          c.buildMenuItem(id: menuItem.id, restaurantId: menuItem.restaurantId),
    );

    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        title: Text(
          currentMenuItem.name,
          style: GoogleFonts.yeonSung(color: kTextRed, fontSize: 28),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Image.asset(kBackArrowIcon),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 26.h),
            _buildImageCarousel(cubit),
            SizedBox(height: 20.h),
            _buildDetailsSection(currentMenuItem),
            SizedBox(height: 20.h),
            Center(
              child: GradientButton(
                buttonText: "Edit Item",
                onTap: () => cubit.toggleEditMode(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCarousel(MenuItemFormCubit cubit) {
    return BlocBuilder<MenuItemFormCubit, MenuItemFormState>(
      builder: (context, state) {
        return CarouselSlider(
          options: CarouselOptions(
            height: 200.h,
            autoPlay: true,
            viewportFraction: 0.8,
            enlargeCenterPage: true,
          ),
          items:
              state.existingImages.map((url) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    image: DecorationImage(
                      image: NetworkImage(url),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
        );
      },
    );
  }

  Widget _buildDetailsSection(MenuItem menuItem) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Price: ₹${menuItem.price}",
          style: GoogleFonts.yeonSung(fontSize: 20),
        ),
        SizedBox(height: 12.h),
        Text(
          "Available: ${menuItem.availableQuantity}",
          style: GoogleFonts.yeonSung(fontSize: 20),
        ),
        SizedBox(height: 12.h),
        Text("Description:", style: GoogleFonts.yeonSung(fontSize: 20)),
        Text(menuItem.description ?? '', style: GoogleFonts.lato(fontSize: 16)),
        if (menuItem.ingredients != null &&
            menuItem.ingredients!.isNotEmpty) ...[
          SizedBox(height: 12.h),
          Text("Ingredients:", style: GoogleFonts.yeonSung(fontSize: 20)),
          ...menuItem.ingredients!.map(
            (ingredient) =>
                Text("• $ingredient", style: GoogleFonts.lato(fontSize: 16)),
          ),
        ],
      ],
    );
  }
}
