import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious_admin_app/core/constants/colors.dart';
import 'package:foody_licious_admin_app/core/constants/images.dart';
import 'package:foody_licious_admin_app/core/router/app_router.dart';
import 'package:foody_licious_admin_app/core/utils/image_picker_helper.dart';
import 'package:foody_licious_admin_app/domain/entities/menuItem/menuItem.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/delete_menu_item_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/update_menu_item_usecase.dart';
import 'package:foody_licious_admin_app/presentation/bloc/menuItem/menu_item_bloc.dart';
import 'package:foody_licious_admin_app/presentation/widgets/gradient_button.dart';
import 'package:foody_licious_admin_app/presentation/widgets/input_text_form_field.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuItemDetailsView extends StatefulWidget {
  final MenuItem? menuItem;
  const MenuItemDetailsView({super.key, this.menuItem});

  @override
  State<MenuItemDetailsView> createState() => _MenuItemDetailsViewState();
}

class _MenuItemDetailsViewState extends State<MenuItemDetailsView> {
  TextEditingController _ingredientsController = TextEditingController();
  TextEditingController _itemNameController = TextEditingController();
  TextEditingController _itemPriceController = TextEditingController();
  TextEditingController _itemQuantityController = TextEditingController();
  TextEditingController _itemDescriptionController = TextEditingController();
  final List<String> _ingredients = [];
  List<String> existingImagesPaths = [];
  List<String> selectedImagesPaths = [];
  bool isEditModeOn = false;

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
  void initState() {
    _ingredientsController = TextEditingController();
    _itemNameController = TextEditingController(text: widget.menuItem?.name);
    _itemPriceController = TextEditingController(
      text: widget.menuItem?.price.toString(),
    );
    _itemQuantityController = TextEditingController(
      text: widget.menuItem?.availableQuantity.toString(),
    );
    _itemDescriptionController = TextEditingController(
      text: widget.menuItem?.description,
    );
    existingImagesPaths.addAll(widget.menuItem?.images ?? []);
    _ingredients.addAll(widget.menuItem?.ingredients ?? []);
    super.initState();
  }

  @override
  void dispose() {
    existingImagesPaths.clear();
    _ingredients.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isEditModeOn) {
      return _buildItemDetailsEditModeView(context);
    } else {
      return _buildItemDetailsView(context);
    }
  }

  Widget _buildItemDetailsEditModeView(context) {
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
        } else if (state is MenuItemDeleteSuccess) {
          EasyLoading.showSuccess("Menu Item Deleted Successfully!");
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
          // Navigate to allMenuPage
          Navigator.pop(context);
        } else if (state is MenuItemDeleteFailed) {
          EasyLoading.showError("Failed to Delete Menu Item");
        } else if (state is MenuItemUpdateLoading) {
          EasyLoading.show(status: "Loading...");
        } else if (state is MenuItemUpdateSuccess) {
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
          // Navigate to allMenuPage
          Navigator.pop(context);
          EasyLoading.showSuccess("Menu Item updated Successfully!");
        } else if (state is MenuItemUpdateFailed) {
          EasyLoading.showError("Failed to Update Menu Item");
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Update Item",
            style: GoogleFonts.yeonSung(color: kTextRed, fontSize: 40),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              setState(() {
                isEditModeOn = !isEditModeOn;
              });
            },
            icon: Image.asset(kBackArrowIcon),
          ),
          automaticallyImplyLeading: true,
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
                  textController: _itemQuantityController,
                  labelText: "Available Quantity",
                  inputFormatters: [
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      final digitsOnly = newValue.text.replaceAll(
                        RegExp(r'[^0-9]'),
                        '',
                      );
                      return newValue.copyWith(
                        text: digitsOnly,
                        selection: TextSelection.collapsed(
                          offset: digitsOnly.length,
                        ),
                      );
                    }),
                  ],
                  labelStyle: GoogleFonts.yeonSung(
                    color: kTextPrimary,
                    fontSize: 14,
                  ),
                  hintText: "Enter available quantity",
                  hintStyle: GoogleFonts.yeonSung(
                    color: kTextPrimary,
                    fontSize: 14,
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                  validatorText: "Please enter your valid quantity",
                ),
                SizedBox(height: 12.h),
                InputTextFormField(
                  textController: _itemPriceController,
                  labelText: "Item Price",
                  inputFormatters: [
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      final digitsOnly = newValue.text.replaceAll(
                        RegExp(r'[^0-9]'),
                        '',
                      );
                      return newValue.copyWith(
                        text: digitsOnly,
                        selection: TextSelection.collapsed(
                          offset: digitsOnly.length,
                        ),
                      );
                    }),
                  ],
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
                    if (images.length > 3 - existingImagesPaths.length) {
                      if (3 - existingImagesPaths.length == 0) {
                        EasyLoading.showError(
                          "Maximum 3 images are allowed.\n To add new images delete existing images first.",
                        );
                      } else {
                        EasyLoading.showError(
                          "Maximum 3 images are allowed.\n You can add only ${3 - existingImagesPaths.length} images now.\nTo add new images delete existing images first.",
                        );
                      }
                    } else {
                      setState(() => selectedImagesPaths = images);
                    }
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
                if ((widget.menuItem?.images?.isNotEmpty ?? false) ||
                    selectedImagesPaths.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Existing images (from network)
                      ...existingImagesPaths.map((img) {
                        return Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: kBorder, width: 2.0),
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: Image.network(
                                img,
                                fit: BoxFit.fill,
                                width: 100,
                                height: 100,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() => existingImagesPaths.remove(img));
                              },
                              child: const Icon(
                                Icons.delete,
                                size: 18,
                                color: kPrimaryRed,
                              ),
                            ),
                          ],
                        );
                      }),

                      // Selected new images (from local files)
                      ...selectedImagesPaths.map((img) {
                        return Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: kBorder, width: 2.0),
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
                                setState(() => selectedImagesPaths.remove(img));
                              },
                              child: const Icon(
                                Icons.delete,
                                size: 18,
                                color: kPrimaryRed,
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GradientButton(
                        buttonText: "Update Item",
                        onTap: () {
                          this.context.read<MenuItemBloc>().add(
                            UpdateMenuItem(
                              UpdateMenuItemParams(
                                id: widget.menuItem!.id,
                                name: _itemNameController.text,
                                description: _itemDescriptionController.text,
                                price:
                                    int.tryParse(_itemPriceController.text) ??
                                    0,
                                availableQuantity:
                                    int.tryParse(
                                      _itemQuantityController.text,
                                    ) ??
                                    0,
                                ingredients: _ingredients,
                                images: [
                                  ...existingImagesPaths,
                                  ...selectedImagesPaths,
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      GradientButton(
                        buttonText: "Delete Item",
                        onTap: () {
                          this.context.read<MenuItemBloc>().add(
                            DeleteMenuItem(
                              DeleteMenuItemParams(itemId: widget.menuItem!.id),
                            ),
                          );
                        },
                      ),
                    ],
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

  Widget _buildItemDetailsView(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        title: Text(
          widget.menuItem?.name ?? "Food Name",
          style: GoogleFonts.yeonSung(color: kTextRed, fontSize: 28),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(kBackArrowIcon),
        ),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 26.h),
              CarouselSlider(
                options: CarouselOptions(
                  height: 200.h,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 10),
                  viewportFraction: 0.8,
                  enlargeCenterPage: true,
                ),
                items:
                    widget.menuItem?.images?.map((img) {
                      return Container(
                        height: 250.h,
                        width: 350.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          image: DecorationImage(
                            image: NetworkImage(img),
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    }).toList(),
              ),
              SizedBox(height: 20.h),
              Text(
                "Price\n${widget.menuItem?.price}",
                style: GoogleFonts.yeonSung(color: kBlack, fontSize: 20),
              ),
              SizedBox(height: 20.h),
              Text(
                "Available Quantity\n${widget.menuItem?.availableQuantity}",
                style: GoogleFonts.yeonSung(color: kBlack, fontSize: 20),
              ),
              SizedBox(height: 20.h),
              Text(
                "Short description",
                style: GoogleFonts.yeonSung(color: kBlack, fontSize: 20),
              ),
              SizedBox(height: 6.h),
              Text(
                widget.menuItem?.description ??
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad",
                style: GoogleFonts.lato(
                  color: kBlack,
                  fontSize: 14,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "Ingredients",
                style: GoogleFonts.yeonSung(color: kBlack, fontSize: 20),
              ),
              SizedBox(
                child: ListView.builder(
                  physics: ScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  shrinkWrap: true,
                  itemCount: widget.menuItem?.ingredients?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(
                      "\u2022 ${widget.menuItem?.ingredients?[index]}",
                      style: GoogleFonts.lato(color: kBlack, fontSize: 16),
                    );
                  },
                ),
              ),
              SizedBox(height: 20.h),
              Center(
                child: GradientButton(
                  buttonText: "Edit Item",
                  onTap: () {
                    setState(() {
                      isEditModeOn = !isEditModeOn;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
