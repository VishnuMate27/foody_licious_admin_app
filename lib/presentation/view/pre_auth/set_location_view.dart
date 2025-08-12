import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious_admin_app/core/constants/images.dart';
import 'package:foody_licious_admin_app/presentation/widgets/gradient_button.dart';
import 'package:foody_licious_admin_app/presentation/widgets/input_text_form_field.dart';
import 'package:foody_licious_admin_app/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class SetLocationView extends StatefulWidget {
  const SetLocationView({super.key});

  @override
  State<SetLocationView> createState() => _SetLocationViewState();
}

class _SetLocationViewState extends State<SetLocationView> {
  final TextEditingController _restaurantNameController =
      TextEditingController();
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
              Center(child: Image.asset(kLogo, width: 90.w, height: 90.h)),
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
              InputTextFormField(
                textController: _restaurantNameController,
                labelText: "Name of Restaurant",
                hintText: "Enter Name of Restaurant",
                prefixIconData: Icons.person_2_outlined,
                keyboardType: TextInputType.name,
                validatorText: "Please enter your Restaurant Name",
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
                child: GradientButton(
                  buttonText: "Create Account",
                  onTap: () {},
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
