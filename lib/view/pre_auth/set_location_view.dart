import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious_admin_app/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class SetLocationView extends StatefulWidget {
  const SetLocationView({super.key});

  @override
  State<SetLocationView> createState() => _SetLocationViewState();
}

class _SetLocationViewState extends State<SetLocationView> {
  String dropdownValue = availableCitiesList.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32.h),
              Center(
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 90.w,
                  height: 90.h,
                ),
              ),
              Center(
                child: Text(
                  "Foody Licious",
                  style: GoogleFonts.yeonSung(
                    color: Color(0xFFE85353),
                    fontSize: 40,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: Text(
                  "Sign Up Here For Your\nAdmin Dashboard",
                  style: GoogleFonts.lato(
                    color: Color(0xFFBB0C24),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "Name of Restaurant",
                style: GoogleFonts.yeonSung(
                  color: Color(0xFFBB0C24),
                  fontSize: 14,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 4.h),
              TextFormField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  fillColor: Color(0xFFF4F4F4),
                  labelText: 'Name of Restaurant',
                  labelStyle: GoogleFonts.lato(
                    color: Color(0xFF3B3B3B),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0.5,
                  ),
                  hintText: 'Enter Name of Restaurant',
                  prefixIcon: Icon(
                    Icons.person_2_outlined,
                    color: Colors.black,
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
              SizedBox(height: 16.h),
              Text(
                "Choose Your Location",
                style: GoogleFonts.yeonSung(
                  color: Color(0xFFBB0C24),
                  fontSize: 14,
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
              SizedBox(height: 32.h),
              Center(
                child: GestureDetector(
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
                        "Create Account",
                        style: GoogleFonts.yeonSung(
                          color: Color(0xFFFFFFFF),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
