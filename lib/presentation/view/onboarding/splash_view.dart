import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious_admin_app/core/constants/colors.dart';
import 'package:foody_licious_admin_app/core/router/app_router.dart';
import 'package:foody_licious_admin_app/presentation/bloc/restaurant/restaurant_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<RestaurantBloc, RestaurantState>(
      listener: (context, state) async {
        EasyLoading.dismiss();
        if (state is RestaurantAuthenticated) {
          await Future.delayed(Duration(seconds: 2));
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRouter.dashboard,
            (Route<dynamic> route) => false,
            arguments: {'previousCity': state.restaurant.address?.city},
          );
        } else if (state is RestaurantUnauthenticated) {
          await Future.delayed(Duration(seconds: 5));
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRouter.login,
            (Route<dynamic> route) => false,
          );
        }
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "assets/images/logo.png",
                width: 185.w,
                height: 189.h,
              ),
            ),
            SizedBox(height: 42.h),
            Text(
              "Foody Licious",
              style: GoogleFonts.yeonSung(color: kTextRed, fontSize: 40),
            ),
            SizedBox(height: 40.h),
            Text(
              "Admin Dashboard",
              style: GoogleFonts.lato(
                color: kTextRed,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
