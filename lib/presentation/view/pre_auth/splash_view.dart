import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious_admin_app/core/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
