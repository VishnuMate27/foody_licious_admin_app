import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AddMenuView extends StatefulWidget {
  const AddMenuView({Key? key}) : super(key: key);

  @override
  _AddMenuViewState createState() => _AddMenuViewState();
}

class _AddMenuViewState extends State<AddMenuView> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _ingredients = [];
  void _addIngredients() {
    String text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _ingredients.add(text);
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Item",
          style: GoogleFonts.yeonSung(color: Color(0xFFE85353), fontSize: 40),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.h),
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              fillColor: Color(0xFFF4F4F4),
              labelText: 'Item Name',
              labelStyle: GoogleFonts.yeonSung(
                color: Color(0xFF000000),
                fontSize: 14,
                fontWeight: FontWeight.normal,
                letterSpacing: 0,
              ),
              hintText: 'Enter Item name',
              hintStyle: GoogleFonts.yeonSung(
                color: Color(0xFF000000),
                fontSize: 14,
                fontWeight: FontWeight.normal,
                letterSpacing: 0,
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
                  color: Color(0x51FF8080), // Transparent border when disabled
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
          SizedBox(height: 8.h),
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              fillColor: Color(0xFFF4F4F4),
              labelText: 'Item Price',
              labelStyle: GoogleFonts.yeonSung(
                color: Color(0xFF000000),
                fontSize: 14,
                fontWeight: FontWeight.normal,
                letterSpacing: 0,
              ),
              hintText: 'Enter Item Price',
              hintStyle: GoogleFonts.yeonSung(
                color: Color(0xFF000000),
                fontSize: 14,
                fontWeight: FontWeight.normal,
                letterSpacing: 0,
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
                  color: Color(0x51FF8080), // Transparent border when disabled
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
          SizedBox(height: 8.h),
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
                    "Add Image",
                    style: GoogleFonts.yeonSung(
                      color: Color(0xFF000000),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: Icon(
                      CupertinoIcons.add_circled,
                      color: Color(0xFF000000),
                      size: 24.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Center(
            child: Container(
              width: 174.w,
              height: 118.h,
              child: Image(
                image: AssetImage("assets/images/AttachedMenuPhoto.png"),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          TextFormField(
            keyboardType: TextInputType.text,
            // expands: true,
            minLines: 1,
            maxLines: 5,
            decoration: InputDecoration(
              fillColor: Color(0xFFF4F4F4),
              labelText: 'Short Description',
              labelStyle: GoogleFonts.yeonSung(
                color: Color(0xFF000000),
                fontSize: 14,
                fontWeight: FontWeight.normal,
                letterSpacing: 0,
              ),
              hintText: 'Enter Short Description',
              hintStyle: GoogleFonts.yeonSung(
                color: Color(0xFF000000),
                fontSize: 14,
                fontWeight: FontWeight.normal,
                letterSpacing: 0,
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
                  color: Color(0x51FF8080), // Transparent border when disabled
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
          SizedBox(height: 8.h),
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad ",
            style: GoogleFonts.lato(
              color: Color(0xFF000000),
              fontSize: 14,
              fontWeight: FontWeight.normal,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _controller,
                  keyboardType: TextInputType.text,
                  // expands: true,
                  minLines: 1,
                  maxLines: 5,
                  decoration: InputDecoration(
                    fillColor: Color(0xFFF4F4F4),
                    labelText: 'Ingredients',
                    labelStyle: GoogleFonts.yeonSung(
                      color: Color(0xFF000000),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0,
                    ),
                    hintText: 'Enter Ingredients',
                    hintStyle: GoogleFonts.yeonSung(
                      color: Color(0xFF000000),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0,
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
              ),
              SizedBox(width: 8.w),
              ElevatedButton(
                onPressed: _addIngredients,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFE85353),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  minimumSize: Size(40.w, 36.h),
                ),
                child: Text(
                  'Add',
                  style: GoogleFonts.yeonSung(
                    color: Color(0xFFFFFFFF),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Expanded(
            child:
                _ingredients.isEmpty
                    ? SizedBox()
                    : ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      itemCount: _ingredients.length,
                      itemBuilder:
                          (_, index) => Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.fiber_manual_record, size: 10),
                              SizedBox(width: 6), // control spacing here
                              Expanded(child: Text(_ingredients[index])),
                            ],
                          ),
                    ),
          ),
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
                    "Add Item",
                    style: GoogleFonts.yeonSung(
                      color: Color(0xFFFFFFFF),
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
