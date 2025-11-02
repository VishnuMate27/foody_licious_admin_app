import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious_admin_app/core/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class InputTextFormField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final TextEditingController textController;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final bool? showlabelTextOnBorder;
  final Widget? suffixIcon;
  final IconData? prefixIconData;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final bool readOnly;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? validatorText;
  final bool obscureText; // initial value
  final Function()? onEditingComplete;

  const InputTextFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.textController,
    this.labelStyle,
    this.hintStyle,
    this.showlabelTextOnBorder = true,
    this.suffixIcon,
    this.prefixIconData,
    this.maxLength,
    this.minLines,
    this.maxLines,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.inputFormatters = const [],
    this.validatorText = "This field cannot be empty.",
    this.obscureText = false,
    this.onEditingComplete,
  });

  @override
  State<InputTextFormField> createState() => _InputTextFormFieldState();
}

class _InputTextFormFieldState extends State<InputTextFormField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.maxLength,
      minLines: widget.minLines,
      maxLines: widget.obscureText == false ? widget.maxLines : 1,
      controller: widget.textController,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      obscureText: _obscure,
      readOnly: widget.readOnly,
      decoration: InputDecoration(
        fillColor: const Color.fromARGB(255, 49, 42, 42),
        labelText: widget.labelText,
        labelStyle:
            widget.labelStyle ??
            GoogleFonts.lato(
              color: kTextSecondary,
              fontSize: 14,
              fontWeight: FontWeight.normal,
              letterSpacing: 0.5,
            ),
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        floatingLabelBehavior:
            widget.showlabelTextOnBorder == true
                ? FloatingLabelBehavior.auto
                : FloatingLabelBehavior.never,
        prefixIcon:
            widget.prefixIconData != null
                ? Icon(widget.prefixIconData, color: kBlack)
                : null,
        suffixIcon:
            (widget.suffixIcon != null || widget.obscureText)
                ? widget.obscureText
                    ? IconButton(
                      icon: Icon(
                        _obscure
                            ? CupertinoIcons.eye
                            : CupertinoIcons.eye_slash,
                        size: 20,
                        color: kBlack,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscure = !_obscure;
                        });
                      },
                    )
                    : widget.suffixIcon
                : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: kBorderLight, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: kBorder, width: 1.sp),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: kBorder, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: kError, width: 1),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: kBorder, width: 1),
        ),
      ),
      onEditingComplete: widget.onEditingComplete,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return widget.validatorText;
        }
        return null;
      },
    );
  }
}
