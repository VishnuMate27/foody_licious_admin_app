import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 82.h),
              Center(
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 90.w,
                  height: 90.h,
                ),
              ),
              Text(
                "Foody Licious",
                style: GoogleFonts.yeonSung(
                  color: Color(0xFFE85353),
                  fontSize: 40,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "Deliever Favorite Food",
                style: GoogleFonts.lato(
                  color: Color(0xFFBB0C24),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 28.h),
              Text(
                "Login To Your\nAdmin Dashboard",
                style: GoogleFonts.lato(
                  color: Color(0xFFBB0C24),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 28.h),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  fillColor: Color(0xFFF4F4F4),
                  labelText: 'Email or Phone Number',
                  labelStyle: GoogleFonts.lato(
                    color: Color(0xFF3B3B3B),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0.5,
                  ),
                  hintText: 'Enter email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color(0x80F4F4F4), // Make the border transparent
                      width: 1, // Set the border width to 0
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color(
                        0x51FF8080,
                      ), // Transparent border when not focused
                      width: 1.sp,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color(
                        0x51FF8080,
                      ), // Transparent border when focused
                      width: 1,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color(
                        0xCCFF0000,
                      ), // Transparent border for error state
                      width: 1,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color(
                        0x51FF8080,
                      ), // Transparent border when disabled
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
                  fillColor: Color(0xFFF4F4F4),
                  labelText: 'Password',
                  labelStyle: GoogleFonts.lato(
                    color: Color(0xFF3B3B3B),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0.5,
                  ),
                  hintText: 'Enter Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color(0x51FF8080), // Make the border transparent
                      width: 1, // Set the border width to 0
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color(
                        0x51FF8080,
                      ), // Transparent border when not focused
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color(
                        0x51FF8080,
                      ), // Transparent border when focused
                      width: 1,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color(
                        0xCCFF0000,
                      ), // Transparent border for error state
                      width: 1,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color(
                        0x51FF8080,
                      ), // Transparent border when disabled
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
              SizedBox(height: 28.h),
              Text(
                "Or",
                style: GoogleFonts.yeonSung(
                  color: Color(0xFF09051C),
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                "Continue With",
                style: GoogleFonts.yeonSung(
                  color: Color(0xFF09051C),
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Color(0x51FF8080),
                          width: 1.0,
                          style: BorderStyle.solid,
                        ),
                      ),
                      width: 152.w,
                      height: 57.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/facebook.png",
                            width: 25.w,
                            height: 25.h,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            "Facebook",
                            style: GoogleFonts.lato(
                              color: Color(0xFF09051C),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Color(0x51FF8080),
                          width: 1.0,
                          style: BorderStyle.solid,
                        ),
                      ),
                      width: 152.w,
                      height: 57.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/google.png",
                            width: 25.w,
                            height: 25.h,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            "Google",
                            style: GoogleFonts.lato(
                              color: Color(0xFF09051C),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      colors: [Color(0xFFE85353), Color(0xFFBE1515)],
                      stops: [0.0, 1.0],
                    ),
                  ),
                  width: 157.w,
                  height: 57.h,
                  child: Center(
                    child: Text(
                      "Login",
                      style: GoogleFonts.yeonSung(
                        color: Color(0xFFFFFFFF),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "Don’t Have Account?",
                style: GoogleFonts.lato(
                  color: Color(0xFFBB0C24),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
