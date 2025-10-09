import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious_admin_app/core/constants/colors.dart';
import 'package:foody_licious_admin_app/core/constants/images.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 98.h,
          ),
          Center(
            child: Image.asset(
              kBurger,
              width: 333.w,
              height: 312.h,
            ),
          ),
          SizedBox(
            height: 42.h,
          ),
          Text(
            "Enjoy Restaurant Quality Meals at Home",
            style: GoogleFonts.yeonSung(color: kTextRedDark, fontSize: 20),
          ),
          SizedBox(
            height: 160.h,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [kGradientStart, kGradientEnd],
                    stops: [0.0, 1.0],
                  )),
              width: 157.w,
              height: 57.h,
              child: Center(
                  child: Text(
                "Next",
                style: GoogleFonts.yeonSung(color: kWhite, fontSize: 20),
              )),
            ),
          )
        ],
      ),
    );
  }
}
