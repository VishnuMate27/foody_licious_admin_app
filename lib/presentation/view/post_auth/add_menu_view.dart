import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious_admin_app/core/constants/colors.dart';
import 'package:foody_licious_admin_app/core/constants/images.dart';
import 'package:foody_licious_admin_app/presentation/widgets/gradient_button.dart';
import 'package:foody_licious_admin_app/presentation/widgets/input_text_form_field.dart';
import 'package:google_fonts/google_fonts.dart';

class AddMenuView extends StatefulWidget {
  const AddMenuView({Key? key}) : super(key: key);

  @override
  _AddMenuViewState createState() => _AddMenuViewState();
}

class _AddMenuViewState extends State<AddMenuView> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _ingredients = [];
  void _addIngredients() {
    String text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _ingredients.add(text);
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _itemNameController = TextEditingController();
    final TextEditingController _itemPriceController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Item",
          style: GoogleFonts.yeonSung(color: kTextRed, fontSize: 40),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            InputTextFormField(
              textController: _itemNameController,
              labelText: "Item Name",
              labelStyle: GoogleFonts.yeonSung(
                color: kTextPrimary,
                fontSize: 14,
                fontWeight: FontWeight.normal,
                letterSpacing: 0,
              ),
              hintText: "Enter Item name",
              hintStyle: GoogleFonts.yeonSung(
                color: kTextPrimary,
                fontSize: 14,
                fontWeight: FontWeight.normal,
                letterSpacing: 0,
              ),
              keyboardType: TextInputType.text,
              validatorText: "Please enter your valid Item name",
            ),
            SizedBox(height: 8.h),
            InputTextFormField(
              textController: _itemNameController,
              labelText: "Item Price",
              labelStyle: GoogleFonts.yeonSung(
                color: kTextPrimary,
                fontSize: 14,
                fontWeight: FontWeight.normal,
                letterSpacing: 0,
              ),
              hintText: "Enter Item price",
              hintStyle: GoogleFonts.yeonSung(
                color: kTextPrimary,
                fontSize: 14,
                fontWeight: FontWeight.normal,
                letterSpacing: 0,
              ),
              keyboardType: TextInputType.number,
              validatorText: "Please enter your valid Item price",
            ),
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              height: 56.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: kBorder, // Transparent border
                  width: 1.sp,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Add Image",
                      style: GoogleFonts.yeonSung(
                        color: kTextPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: Icon(
                        CupertinoIcons.add_circled,
                        color: kTextPrimary,
                        size: 24.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Center(
              child: Container(
                width: 174.w,
                height: 118.h,
                child: Image(image: AssetImage(kAttachedMenuPhoto)),
              ),
            ),
            SizedBox(height: 8.h),
            InputTextFormField(
              minLines: 1,
              maxLines: 5,
              textController: _itemNameController,
              labelText: "Short Description",
              labelStyle: GoogleFonts.yeonSung(
                color: kTextPrimary,
                fontSize: 14,
                fontWeight: FontWeight.normal,
                letterSpacing: 0,
              ),
              hintText: "Enter Short Description",
              hintStyle: GoogleFonts.yeonSung(
                color: kTextPrimary,
                fontSize: 14,
                fontWeight: FontWeight.normal,
                letterSpacing: 0,
              ),
              keyboardType: TextInputType.text,
              validatorText: "Please enter your valid short description",
            ),
            SizedBox(height: 8.h),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad ",
              style: GoogleFonts.lato(
                color: kTextPrimary,
                fontSize: 14,
                fontWeight: FontWeight.normal,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Expanded(
                  child: InputTextFormField(
                    textController: _itemNameController,
                    labelText: "Ingredients",
                    labelStyle: GoogleFonts.yeonSung(
                      color: kTextPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0,
                    ),
                    hintText: "Enter Ingredients",
                    hintStyle: GoogleFonts.yeonSung(
                      color: kTextPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0,
                    ),
                    keyboardType: TextInputType.text,
                    validatorText: "Please enter valid ingredients",
                  ),
                ),
                SizedBox(width: 8.w),
                ElevatedButton(
                  onPressed: _addIngredients,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    minimumSize: Size(40.w, 36.h),
                  ),
                  child: Text(
                    'Add',
                    style: GoogleFonts.yeonSung(
                      color: kWhite,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Expanded(
              child:
                  _ingredients.isEmpty
                      ? SizedBox()
                      : ListView.builder(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        itemCount: _ingredients.length,
                        itemBuilder:
                            (_, index) => Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.fiber_manual_record, size: 10),
                                SizedBox(width: 6), // control spacing here
                                Expanded(child: Text(_ingredients[index])),
                              ],
                            ),
                      ),
            ),
            Center(child: GradientButton(buttonText: "Add Item", onTap: () {})),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
