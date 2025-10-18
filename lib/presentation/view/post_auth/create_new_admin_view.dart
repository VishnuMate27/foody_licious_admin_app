import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious_admin_app/core/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateNewAdminView extends StatefulWidget {
  const CreateNewAdminView({super.key});

  @override
  State<CreateNewAdminView> createState() => _CreateNewAdminViewState();
}

class _CreateNewAdminViewState extends State<CreateNewAdminView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset("assets/icons/back_arrow.png", color: kBlack),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 90.w,
                  height: 90.h,
                ),
              ),
              Text(
                "Foody Licious",
                style: GoogleFonts.yeonSung(color: kTextRed, fontSize: 40),
              ),
              SizedBox(height: 10.h),
              Text(
                "Create New User Admin",
                style: GoogleFonts.lato(
                  color: kTextOnPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.h),
              TextFormField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  fillColor: kCardBackground,
                  labelText: 'Name',
                  labelStyle: GoogleFonts.lato(
                    color: kTextOnPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0.5,
                  ),
                  hintText: 'Enter name',
                  prefixIcon: Icon(Icons.person_2_outlined, color: kBlack),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: kBorder, // Make the border transparent
                      width: 1, // Set the border width to 0
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: kBorder, // Transparent border when not focused
                      width: 1.sp,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: kBorder, // Transparent border when focused
                      width: 1,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: kError, // Transparent border for error state
                      width: 1,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: kBorder, // Transparent border when disabled
                      width: 1,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {},
              ),
              SizedBox(height: 12.h),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  fillColor: kCardBackground,
                  labelText: 'Email or Phone Number',
                  labelStyle: GoogleFonts.lato(
                    color: kTextOnPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0.5,
                  ),
                  hintText: 'Enter email',
                  prefixIcon: Icon(Icons.mail_outlined, color: kBlack),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: kBorder, // Make the border transparent
                      width: 1, // Set the border width to 0
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: kBorder, // Transparent border when not focused
                      width: 1.sp,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: kBorder, // Transparent border when focused
                      width: 1,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: kError, // Transparent border for error state
                      width: 1,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: kBorder, // Transparent border when disabled
                      width: 1,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {},
              ),
              SizedBox(height: 12.h),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  fillColor: kCardBackground,
                  labelText: 'Password',
                  labelStyle: GoogleFonts.lato(
                    color: kTextOnPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0.5,
                  ),
                  hintText: 'Enter Password',
                  prefixIcon: Icon(Icons.lock_outline, color: kBlack),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: kBorder, // Make the border transparent
                      width: 1, // Set the border width to 0
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: kBorder, // Transparent border when not focused
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: kBorder, // Transparent border when focused
                      width: 1,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: kError, // Transparent border for error state
                      width: 1,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: kBorder, // Transparent border when disabled
                      width: 1,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {},
              ),
              SizedBox(height: 36.h),
              GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      colors: [kGradientStart, kGradientEnd],
                      stops: [0.0, 1.0],
                    ),
                  ),
                  width: 157.w,
                  height: 57.h,
                  child: Center(
                    child: Text(
                      "Create New User",
                      style: GoogleFonts.yeonSung(color: kWhite, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
