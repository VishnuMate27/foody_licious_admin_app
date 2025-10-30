import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious_admin_app/core/constants/colors.dart';
import 'package:foody_licious_admin_app/core/utils/image_picker_helper.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/add_menu_item_usecase.dart';
import 'package:foody_licious_admin_app/presentation/bloc/menuItem/menu_item_bloc.dart';
import 'package:foody_licious_admin_app/presentation/widgets/gradient_button.dart';
import 'package:foody_licious_admin_app/presentation/widgets/input_text_form_field.dart';
import 'package:google_fonts/google_fonts.dart';

class AddMenuView extends StatefulWidget {
  const AddMenuView({Key? key}) : super(key: key);

  @override
  _AddMenuViewState createState() => _AddMenuViewState();
}

class _AddMenuViewState extends State<AddMenuView> {
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemPriceController = TextEditingController();
  final TextEditingController _itemDescriptionController =
      TextEditingController();
  final List<String> _ingredients = [];
  List<String> selectedImagesPaths = [];

  void _addIngredients() {
    String text = _ingredientsController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _ingredients.add(text);
        _ingredientsController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MenuItemBloc, MenuItemState>(
      listener: (context, state) {
        if (state is MenuItemAddLoading) {
          EasyLoading.show(status: "Loading...");
        } else if (state is MenuItemAddSuccess) {
          EasyLoading.showSuccess("Menu Item Added Successfully!");

          // Clear all controllers
          _itemNameController.clear();
          _itemPriceController.clear();
          _itemDescriptionController.clear();
          _ingredientsController.clear();
          // Clear ingredient list
          setState(() {
            selectedImagesPaths.clear();
            _ingredients.clear();
          });
        } else if (state is MenuItemAddFailed) {
          EasyLoading.showError("Failed to Add Menu Item");
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Add Item",
            style: GoogleFonts.yeonSung(color: kTextRed, fontSize: 40),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
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
                  ),
                  hintText: "Enter Item name",
                  hintStyle: GoogleFonts.yeonSung(
                    color: kTextPrimary,
                    fontSize: 14,
                  ),
                  keyboardType: TextInputType.text,
                  validatorText: "Please enter your valid Item name",
                ),
                SizedBox(height: 12.h),
                InputTextFormField(
                  textController: _itemPriceController,
                  labelText: "Item Price",
                  labelStyle: GoogleFonts.yeonSung(
                    color: kTextPrimary,
                    fontSize: 14,
                  ),
                  hintText: "Enter Item price",
                  hintStyle: GoogleFonts.yeonSung(
                    color: kTextPrimary,
                    fontSize: 14,
                  ),
                  keyboardType: TextInputType.number,
                  validatorText: "Please enter your valid Item price",
                ),
                SizedBox(height: 12.h),
                InkWell(
                  onTap: () async {
                    final images = await ImagePickerHelper.pickMultipleImages();
                    setState(() => selectedImagesPaths = images);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 56.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: kBorder, width: 1.sp),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Add Images (max 3)",
                            style: GoogleFonts.yeonSung(
                              color: kTextPrimary,
                              fontSize: 14,
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
                ),
                SizedBox(height: 12.h),
                if (selectedImagesPaths.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:
                        selectedImagesPaths.map((img) {
                          return Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: kBorder,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: Image.file(
                                  File(img),
                                  fit: BoxFit.fill,
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(
                                    () => selectedImagesPaths.remove(img),
                                  );
                                },
                                child: const Icon(
                                  Icons.delete,
                                  size: 18,
                                  color: kPrimaryRed,
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                  ),
                // SizedBox(height: 12.h),
                // Center(
                //   child: SizedBox(
                //     width: 174.w,
                //     height: 118.h,
                //     child: const Image(image: AssetImage(kAttachedMenuPhoto)),
                //   ),
                // ),
                SizedBox(height: 12.h),
                InputTextFormField(
                  minLines: 1,
                  maxLines: 5,
                  textController: _itemDescriptionController,
                  labelText: "Short Description",
                  labelStyle: GoogleFonts.yeonSung(
                    color: kTextPrimary,
                    fontSize: 14,
                  ),
                  hintText: "Enter Short Description",
                  hintStyle: GoogleFonts.yeonSung(
                    color: kTextPrimary,
                    fontSize: 14,
                  ),
                  keyboardType: TextInputType.text,
                  validatorText: "Please enter your valid short description",
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                      child: InputTextFormField(
                        textController:
                            _ingredientsController, // fixed controller
                        labelText: "Ingredients",
                        labelStyle: GoogleFonts.yeonSung(
                          color: kTextPrimary,
                          fontSize: 14,
                        ),
                        hintText: "Enter Ingredients",
                        hintStyle: GoogleFonts.yeonSung(
                          color: kTextPrimary,
                          fontSize: 14,
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
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                if (_ingredients.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    child: Wrap(
                      spacing: 8.w, // horizontal space between chips
                      runSpacing: 6.h, // vertical space between lines
                      children:
                          _ingredients.map((ingredient) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(
                                  color: kPrimaryRed.withOpacity(0.5),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    ingredient,
                                    style: GoogleFonts.lato(
                                      color: kTextPrimary,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  GestureDetector(
                                    onTap: () {
                                      setState(
                                        () => _ingredients.remove(ingredient),
                                      );
                                    },
                                    child: const Icon(
                                      Icons.close,
                                      size: 14,
                                      color: kPrimaryRed,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                SizedBox(height: 20.h),
                Center(
                  child: GradientButton(
                    buttonText: "Add Item",
                    onTap: () {
                      context.read<MenuItemBloc>().add(
                        AddMenuItem(
                          AddMenuItemParams(
                            name: _itemNameController.text,
                            price: int.tryParse(_itemPriceController.text) ?? 0,
                            description: _itemDescriptionController.text,
                            ingredients: _ingredients,
                            imageFilePaths: selectedImagesPaths,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
