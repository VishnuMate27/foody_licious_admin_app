import 'package:flutter/material.dart';
import 'package:foody_licious_admin_app/core/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ContainerChip extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final double fontSize;
  final double borderRadius;
  final Color chipColor;
  final Color textColor;
  final bool isButton;
  const ContainerChip({
    super.key,
    required this.text,
    this.width,
    this.height,
    this.fontSize = 12,
    this.borderRadius = 5,
    this.chipColor = kBluish,
    this.textColor = kWhite,
  }) : isButton = false,
       onTap = null;

  const ContainerChip.button({
    super.key,
    required this.text,
    required this.onTap,
    this.width,
    this.height,
    this.fontSize = 12,
    this.borderRadius = 5,
    this.chipColor = kBluish,
    this.textColor = kWhite,
  }) : isButton = true;
  @override
  Widget build(BuildContext context) {
    if (isButton) {
      return _buildContainerChipButton(context);
    } else {
      return _buildContainerChip(context);
    }
  }

  Widget _buildContainerChip(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.lato(
            color: textColor,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildContainerChipButton(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: chipColor,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.lato(
              color: textColor,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
