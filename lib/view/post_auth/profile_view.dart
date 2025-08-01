import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious_admin_app/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String dropdownValue = availableCitiesList.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Admin Profile",
          style: GoogleFonts.yeonSung(color: Color(0xFFE85353), fontSize: 40),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset("assets/icons/back_arrow.png", color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text(
              "Choose Your Location",
              style: GoogleFonts.yeonSung(
                color: Color(0xFFE85353),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 4.h),
            DropdownMenu<String>(
              trailingIcon: Icon(
                Icons.arrow_circle_down,
                size: 30,
                color: Colors.black,
              ),
              inputDecorationTheme: InputDecorationTheme(
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
                    color: Color(0x51FF8080), // Transparent border when focused
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
              initialSelection: availableCitiesList.first,
              onSelected: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  dropdownValue = value!;
                });
              },
              dropdownMenuEntries:
                  availableCitiesList.map<DropdownMenuEntry<String>>((
                    String value,
                  ) {
                    return DropdownMenuEntry<String>(
                      value: value,
                      label: value,
                    );
                  }).toList(),
              expandedInsets: EdgeInsets.zero,
            ),
            SizedBox(height: 8.h),
            TextFormField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                fillColor: Color(0xFFF4F4F4),
                labelText: 'Name',
                labelStyle: GoogleFonts.yeonSung(
                  color: Color(0xFF000000),
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.5,
                ),
                hintText: 'Enter name',
                hintStyle: GoogleFonts.lato(
                  color: Color(0xFF000000),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.5,
                ),
                suffixIcon: Icon(
                  CupertinoIcons.create,
                  color: Color(0xFF000000),
                ),
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
                    color: Color(0x51FF8080), // Transparent border when focused
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
              minLines: 2,
              maxLines: 5,
              // expands: true,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                fillColor: Color(0xFFF4F4F4),
                labelText: 'Address',
                labelStyle: GoogleFonts.yeonSung(
                  color: Color(0xFF000000),
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.5,
                ),
                hintText: 'Enter full address',
                hintStyle: GoogleFonts.lato(
                  color: Color(0xFF000000),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.5,
                ),
                suffixIcon: Icon(
                  CupertinoIcons.create,
                  color: Color(0xFF000000),
                ),
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
                    color: Color(0x51FF8080), // Transparent border when focused
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
                  return 'Please enter your address';
                }
                return null;
              },
              onSaved: (value) {},
            ),
            SizedBox(height: 18.h),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                fillColor: Color(0xFFF4F4F4),
                labelText: 'Email',
                labelStyle: GoogleFonts.yeonSung(
                  color: Color(0xFF000000),
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.5,
                ),
                hintText: 'Enter your email address',
                hintStyle: GoogleFonts.lato(
                  color: Color(0xFF000000),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.5,
                ),
                suffixIcon: Icon(
                  CupertinoIcons.create,
                  color: Color(0xFF000000),
                ),
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
                    color: Color(0x51FF8080), // Transparent border when focused
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
                  return 'Please enter your email';
                }
                return null;
              },
              onSaved: (value) {},
            ),
            SizedBox(height: 18.h),
            TextFormField(
              maxLength: 10,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                fillColor: Color(0xFFF4F4F4),
                labelText: 'Phone',
                labelStyle: GoogleFonts.yeonSung(
                  color: Color(0xFF000000),
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.5,
                ),
                hintText: 'Enter your 10 digit phone number',
                hintStyle: GoogleFonts.lato(
                  color: Color(0xFF000000),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.5,
                ),
                suffixIcon: Icon(
                  CupertinoIcons.create,
                  color: Color(0xFF000000),
                ),
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
                    color: Color(0x51FF8080), // Transparent border when focused
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
            SizedBox(height: 18.h),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                fillColor: Color(0xFFF4F4F4),
                labelText: 'Password',
                labelStyle: GoogleFonts.yeonSung(
                  color: Color(0xFF000000),
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.5,
                ),
                hintText: 'Enter your password',
                hintStyle: GoogleFonts.lato(
                  color: Color(0xFF000000),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.5,
                ),
                suffixIcon: Icon(
                  CupertinoIcons.create,
                  color: Color(0xFF000000),
                ),
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
                    color: Color(0x51FF8080), // Transparent border when focused
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
            SizedBox(height: 18.h),
            Container(
              width: double.infinity,
              height: 56.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Color(0x51FF8080), // Transparent border
                  width: 1.sp,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Restaurant Image",
                      style: GoogleFonts.yeonSung(
                        color: Color(0xFF000000),
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: Text(
                        "Select Image",
                        style: GoogleFonts.yeonSung(
                          color: Color(0xFF000000),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 18.h),
            GestureDetector(
              onTap: () {
                print("Save Information tapped");
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xFFFEFEFF),
                  border: Border.all(color: Color(0xFFE85353), width: 0.5),
                ),
                height: 57.h,
                child: Center(
                  child: Text(
                    "Save Information",
                    style: GoogleFonts.yeonSung(
                      color: Color(0xFFBE1515),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
