import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious_admin_app/core/extension/failure_extension.dart';
import 'package:foody_licious_admin_app/core/router/app_router.dart';
import 'package:foody_licious_admin_app/presentation/bloc/auth/auth_bloc.dart';
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
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 1), // changes position of shadow
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
          GridView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20.h,
              crossAxisSpacing: 30.w,
              childAspectRatio: 1.5,
            ),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              GestureDetector(
                onTap: () {
                  debugPrint("Add Menu tapped");
                },
                child: Container(
                  width: 150.w,
                  height: 85.w,
                  decoration: BoxDecoration(
                    color: Color(0xFFF0C0C0),
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF6CCB94),
                        // spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          CupertinoIcons.add_circled,
                          size: 30.w,
                          color: Color(0xFFD13131),
                        ),
                        Text(
                          "Add Menu",
                          style: GoogleFonts.yeonSung(
                            color: Color(0xFFD13131),
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  debugPrint("All Item Menu tapped");
                },
                child: Container(
                  width: 150.w,
                  height: 85.w,
                  decoration: BoxDecoration(
                    color: Color(0xFFF0C0C0),
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF6CCB94),
                        // spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          CupertinoIcons.eye,
                          size: 30.w,
                          color: Color(0xFFD13131),
                        ),
                        Text(
                          "All Item Menu",
                          style: GoogleFonts.yeonSung(
                            color: Color(0xFFD13131),
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  debugPrint("Out For Delivery tapped");
                },
                child: Container(
                  width: 150.w,
                  height: 85.w,
                  decoration: BoxDecoration(
                    color: Color(0xFFF0C0C0),
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF6CCB94),
                        // spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          CupertinoIcons.location,
                          size: 30.w,
                          color: Color(0xFFD13131),
                        ),
                        Text(
                          "Out For Delivery",
                          style: GoogleFonts.yeonSung(
                            color: Color(0xFFD13131),
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  debugPrint("Feedback tapped");
                },
                child: Container(
                  width: 150.w,
                  height: 85.w,
                  decoration: BoxDecoration(
                    color: Color(0xFFF0C0C0),
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF6CCB94),
                        // spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          CupertinoIcons.chat_bubble,
                          size: 30.w,
                          color: Color(0xFFD13131),
                        ),
                        Text(
                          "Feedback",
                          style: GoogleFonts.yeonSung(
                            color: Color(0xFFD13131),
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  debugPrint("Profile tapped");
                },
                child: Container(
                  width: 150.w,
                  height: 85.w,
                  decoration: BoxDecoration(
                    color: Color(0xFFF0C0C0),
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF6CCB94),
                        // spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          CupertinoIcons.profile_circled,
                          size: 30.w,
                          color: Color(0xFFD13131),
                        ),
                        Text(
                          "Profile",
                          style: GoogleFonts.yeonSung(
                            color: Color(0xFFD13131),
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  debugPrint("Money On Holed tapped");
                },
                child: Container(
                  width: 150.w,
                  height: 85.w,
                  decoration: BoxDecoration(
                    color: Color(0xFFF0C0C0),
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF6CCB94),
                        // spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          CupertinoIcons.money_dollar,
                          size: 30.w,
                          color: Color(0xFFD13131),
                        ),
                        Text(
                          "Money On Holed",
                          style: GoogleFonts.yeonSung(
                            color: Color(0xFFD13131),
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  debugPrint("Create New User tapped");
                },
                child: Container(
                  width: 150.w,
                  height: 85.w,
                  decoration: BoxDecoration(
                    color: Color(0xFFF0C0C0),
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF6CCB94),
                        // spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          CupertinoIcons.person_add,
                          size: 30.w,
                          color: Color(0xFFD13131),
                        ),
                        Text(
                          "Create New User",
                          style: GoogleFonts.yeonSung(
                            color: Color(0xFFD13131),
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthLoading) {
                    EasyLoading.show(status: "Logging Out...");
                  } else if (state is AuthLoggedOut) {
                    EasyLoading.dismiss();
                    Navigator.of(
                      context,
                      rootNavigator: true,
                    ).pushNamedAndRemoveUntil(
                      AppRouter.login,
                      (Route<dynamic> route) => false,
                    );
                  } else if (state is AuthLoggedOutFailed) {
                    EasyLoading.showError(
                      state.failure.toMessage(
                        defaultMessage: "Failed to Logout!",
                      ),
                    );
                  }
                },
                child: GestureDetector(
                  onTap: () {
                    debugPrint("Log Out tapped");
                  },
                  child: Container(
                    width: 150.w,
                    height: 85.w,
                    decoration: BoxDecoration(
                      color: Color(0xFFF0C0C0),
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF6CCB94),
                          blurRadius: 3,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            CupertinoIcons.add_circled,
                            size: 30.w,
                            color: Color(0xFFD13131),
                          ),
                          Text(
                            "Log Out",
                            style: GoogleFonts.yeonSung(
                              color: Color(0xFFD13131),
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
