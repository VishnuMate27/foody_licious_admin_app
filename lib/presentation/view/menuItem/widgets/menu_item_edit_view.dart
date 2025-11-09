import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious_admin_app/core/utils/image_picker_helper.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/delete_menu_item_usecase.dart';
import 'package:foody_licious_admin_app/presentation/widgets/gradient_button.dart';
import 'package:foody_licious_admin_app/presentation/widgets/input_text_form_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foody_licious_admin_app/core/constants/colors.dart';
import 'package:foody_licious_admin_app/core/constants/images.dart';
import 'package:foody_licious_admin_app/domain/entities/menuItem/menuItem.dart';
import 'package:foody_licious_admin_app/presentation/bloc/menuItem/menu_item_bloc.dart';
import 'package:foody_licious_admin_app/presentation/bloc/menuItem/menu_item_form_cubit.dart';

class MenuItemEditView extends StatelessWidget {
  final MenuItem menuItem;

  const MenuItemEditView({Key? key, required this.menuItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MenuItemFormCubit>();

    return BlocListener<MenuItemBloc, MenuItemState>(
      listener: (context, state) {
        if (state is MenuItemUpdateLoading) {
          EasyLoading.show(status: "Loading...");
        } else if (state is MenuItemUpdateSuccess) {
          EasyLoading.showSuccess("Menu Item Updated Successfully!");
          Navigator.pop(context);
        } else if (state is MenuItemUpdateFailed) {
          EasyLoading.showError("Failed to Update Menu Item");
        } else if (state is MenuItemDeleteSuccess) {
          EasyLoading.showSuccess("Menu Item Deleted Successfully!");
          Navigator.pop(context);
        } else if (state is MenuItemDeleteFailed) {
          EasyLoading.showError("Failed to Delete Menu Item");
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
            onPressed: () => cubit.toggleEditMode(),
            icon: Image.asset(kBackArrowIcon),
          ),
        ),
        body: Form(
          key: cubit.formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),
                _buildNameField(cubit),
                SizedBox(height: 12.h),
                _buildQuantityField(cubit),
                SizedBox(height: 12.h),
                _buildPriceField(cubit),
                SizedBox(height: 12.h),
                _buildImagePicker(context, cubit),
                SizedBox(height: 12.h),
                _buildImageList(cubit),
                SizedBox(height: 12.h),
                _buildDescriptionField(cubit),
                SizedBox(height: 12.h),
                _buildIngredientInput(cubit),
                SizedBox(height: 12.h),
                _buildIngredientsList(cubit),
                SizedBox(height: 20.h),
                _buildActionButtons(context, cubit),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper widgets for form fields
  Widget _buildNameField(MenuItemFormCubit cubit) => InputTextFormField(
    textController: cubit.nameController,
    labelText: "Item Name",
    labelStyle: GoogleFonts.yeonSung(color: kTextPrimary, fontSize: 14),
    hintText: "Enter item name",
    hintStyle: GoogleFonts.yeonSung(color: kTextPrimary, fontSize: 14),
    keyboardType: TextInputType.text,
    validatorText: "Please enter a valid item name",
  );

  Widget _buildQuantityField(MenuItemFormCubit cubit) => InputTextFormField(
    textController: cubit.availableQuantityController,
    labelText: "Available Quantity",
    labelStyle: GoogleFonts.yeonSung(color: kTextPrimary, fontSize: 14),
    hintText: "Enter available quantity",
    hintStyle: GoogleFonts.yeonSung(color: kTextPrimary, fontSize: 14),
    keyboardType: TextInputType.number,
    validatorText: "Please enter a valid quantity",
    inputFormatters: [
      TextInputFormatter.withFunction((oldValue, newValue) {
        final digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
        return newValue.copyWith(
          text: digitsOnly,
          selection: TextSelection.collapsed(offset: digitsOnly.length),
        );
      }),
    ],
  );

  Widget _buildPriceField(MenuItemFormCubit cubit) => InputTextFormField(
    textController: cubit.priceController,
    labelText: "Item Price",
    labelStyle: GoogleFonts.yeonSung(color: kTextPrimary, fontSize: 14),
    hintText: "Enter item price",
    hintStyle: GoogleFonts.yeonSung(color: kTextPrimary, fontSize: 14),
    keyboardType: TextInputType.number,
    validatorText: "Please enter a valid price",
    inputFormatters: [
      TextInputFormatter.withFunction((oldValue, newValue) {
        final digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
        return newValue.copyWith(
          text: digitsOnly,
          selection: TextSelection.collapsed(offset: digitsOnly.length),
        );
      }),
    ],
  );

  Widget _buildDescriptionField(MenuItemFormCubit cubit) => InputTextFormField(
    minLines: 1,
    maxLines: 5,
    textController: cubit.descriptionController,
    labelText: "Short Description",
    labelStyle: GoogleFonts.yeonSung(color: kTextPrimary, fontSize: 14),
    hintText: "Enter Short Description",
    hintStyle: GoogleFonts.yeonSung(color: kTextPrimary, fontSize: 14),
    keyboardType: TextInputType.text,
    validatorText: "Please enter your valid short description",
  );

  // Helper widgets for images
  Widget _buildImagePicker(BuildContext context, MenuItemFormCubit cubit) {
    return InkWell(
      onTap: () async {
        if (!cubit.canAddMoreImages) {
          EasyLoading.showError("Maximum 3 images allowed");
          return;
        }
        final images = await ImagePickerHelper.pickMultipleImages();
        cubit.addNewImages(images);
      },
      child: Container(
        width: double.infinity,
        height: 56.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: kBorder),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                "Add Images (max 3)",
                style: GoogleFonts.yeonSung(color: kTextPrimary, fontSize: 14),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Icon(CupertinoIcons.camera, color: kTextPrimary),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widgets for ingredients
  Widget _buildIngredientInput(MenuItemFormCubit cubit) {
    return Row(
      children: [
        Expanded(
          child: InputTextFormField(
            textController: cubit.ingredientController,
            labelText: "Ingredients",
            labelStyle: GoogleFonts.yeonSung(color: kTextPrimary, fontSize: 14),
            hintText: "Enter ingredient",
            hintStyle: GoogleFonts.yeonSung(color: kTextPrimary, fontSize: 14),
            validatorOn: false,
          ),
        ),
        SizedBox(width: 8.w),
        ElevatedButton(
          onPressed: cubit.addIngredientFromController,
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryRed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            minimumSize: Size(40.w, 36.h),
          ),
          child: Text(
            'Add',
            style: GoogleFonts.yeonSung(color: kWhite, fontSize: 14),
          ),
        ),
      ],
    );
  }

  // Additional helper methods...
  Widget _buildIngredientsList(MenuItemFormCubit cubit) {
    return Wrap(
      spacing: 8.w, // horizontal space between chips
      runSpacing: 6.h, // vertical space between lines
      children:
          cubit.ingredients.map((ingredient) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: kPrimaryRed.withOpacity(0.5)),
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
                      cubit.removeIngredient(ingredient);
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
    );
  }

  Widget _buildActionButtons(BuildContext context, MenuItemFormCubit cubit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GradientButton(
          buttonText: "Update",
          onTap: () {
            if (cubit.validateForm()) {
              context.read<MenuItemBloc>().add(
                UpdateMenuItem(cubit.buildUpdateMenuItemParams(menuItem.id)),
              );
            }
          },
        ),
        GradientButton(
          buttonText: "Delete",
          onTap: () {
            context.read<MenuItemBloc>().add(
              DeleteMenuItem(DeleteMenuItemParams(itemId: menuItem.id)),
            );
          },
        ),
      ],
    );
  }

  Widget _buildImageList(MenuItemFormCubit cubit) {
    return BlocBuilder<MenuItemFormCubit, MenuItemFormState>(
      builder: (context, state) {
        return Wrap(
          spacing: 8.w,
          runSpacing: 6.h,
          children: [
            ...state.existingImages.map(
              (image) => _buildImageItem(image, () {
                cubit.removeExistingImage(image);
              }),
            ),
            ...state.images.map(
              (image) => _buildImageItem(image, () {
                cubit.removeNewImage(image);
              }),
            ),
          ],
        );
      },
    );
  }

  Widget _buildImageItem(String imageUrl, VoidCallback onDelete) {
    return Stack(
      children: [
        Container(
          width: 90.w,
          height: 90.w,
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(color: kBorder, width: 2.0),
            borderRadius: BorderRadius.circular(5.r),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: IconButton(
            iconSize: 22,
            icon: Icon(Icons.close, color: kPrimaryRed),
            onPressed: onDelete,
          ),
        ),
      ],
    );
  }
}
