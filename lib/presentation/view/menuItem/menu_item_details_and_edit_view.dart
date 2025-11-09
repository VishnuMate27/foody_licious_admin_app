import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious_admin_app/core/constants/colors.dart';
import 'package:foody_licious_admin_app/core/constants/images.dart';
import 'package:foody_licious_admin_app/core/utils/image_picker_helper.dart';
import 'package:foody_licious_admin_app/domain/entities/menuItem/menuItem.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/delete_menu_item_usecase.dart';
import 'package:foody_licious_admin_app/presentation/bloc/menuItem/menu_item_bloc.dart';
import 'package:foody_licious_admin_app/presentation/bloc/menuItem/menu_item_form_cubit.dart';
import 'package:foody_licious_admin_app/presentation/view/menuItem/widgets/menu_item_details_view.dart';
import 'package:foody_licious_admin_app/presentation/view/menuItem/widgets/menu_item_edit_view.dart';
import 'package:foody_licious_admin_app/presentation/widgets/gradient_button.dart';
import 'package:foody_licious_admin_app/presentation/widgets/input_text_form_field.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuItemDetailsView extends StatelessWidget {
  final MenuItem? menuItem;

  const MenuItemDetailsView({super.key, this.menuItem});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              MenuItemFormCubit(menuItem)..initializeWithMenuItem(menuItem!),
      child: _MenuItemDetailsContent(
        menuItem: menuItem!,
      ), // Pass menuItem to content
    );
  }
}

class _MenuItemDetailsContent extends StatelessWidget {
  final MenuItem menuItem;

  const _MenuItemDetailsContent({required this.menuItem});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuItemFormCubit, MenuItemFormState>(
      builder: (context, state) {
        if (state.isEditMode) {
          return MenuItemEditView(menuItem: menuItem);
        } else {
          return MenuItemDetailsWidget(menuItem: menuItem);
        }
      },
    );
  }
}
