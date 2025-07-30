import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Foody Licious",
          style: GoogleFonts.yeonSung(color: Color(0xFFE85353), fontSize: 40),
        ),
        leading: Image.asset(
          "assets/images/logo.png",
          width: 24.w,
          height: 24.h,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(14.w),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Color(0xFFF1F1F1),
                borderRadius: BorderRadius.circular(20.r),
                // border: Border.all(color: Color(0xFFE85353), width: 0.5),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFF4F4F4),
                    spreadRadius: 4,
                    blurRadius: 2,
                    offset: Offset(0, 4), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Icon(
                        CupertinoIcons.info,
                        size: 30.w,
                        color: Color(0xFFE85353),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Pending Order",
                        style: GoogleFonts.yeonSung(
                          color: Color(0xFFE85353),
                          fontSize: 20.sp,
                        ),
                      ),
                      Text(
                        "30",
                        style: GoogleFonts.yeonSung(
                          color: Colors.black,
                          fontSize: 20.sp,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        CupertinoIcons.checkmark_alt_circle,
                        size: 24.w,
                        color: Color(0xFF6CCB94),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Completed\nOrders",
                        style: GoogleFonts.yeonSung(
                          color: Color(0xFFE85353),
                          fontSize: 12.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "10",
                        style: GoogleFonts.yeonSung(
                          color: Color(0xFFFEAD1D),
                          fontSize: 20.sp,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        CupertinoIcons.money_dollar_circle,
                        size: 24.w,
                        color: Colors.black,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Whole Time\nEarning",
                        style: GoogleFonts.yeonSung(
                          color: Color(0xFFE85353),
                          fontSize: 12.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "100\$",
                        style: GoogleFonts.yeonSung(
                          color: Color(0xFF53E88B),
                          fontSize: 20.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.h),
          
        ],
      ),
    );
  }
}
