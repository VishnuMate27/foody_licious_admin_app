import 'package:flutter/material.dart';
import 'package:foody_licious_admin_app/core/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class TabChip extends StatelessWidget {
  final String tabName;
  final int tabItemLength;
  final Color selectedTabTextColor;
  final bool isTabSelected;
  const TabChip({
    super.key,
    required this.tabName,
    this.tabItemLength = 0,
    this.selectedTabTextColor = Colors.black,
    this.isTabSelected = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: kTextRed, width: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 4),
        child: Text(
          '$tabName ($tabItemLength)',
          style: GoogleFonts.yeonSung(
            color: isTabSelected ? kTextRed : kBlack,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
