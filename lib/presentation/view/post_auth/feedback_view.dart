import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious_admin_app/core/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedbackView extends StatefulWidget {
  const FeedbackView({super.key});

  @override
  State<FeedbackView> createState() => _FeedbackViewState();
}

class _FeedbackViewState extends State<FeedbackView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Feedback",
          style: GoogleFonts.yeonSung(color: kTextRed, fontSize: 40),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset("assets/icons/back_arrow.png", color: kBlack),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: FeedbackCard(
                    customerName: "Customer Name",
                    starRating: 4,
                    description:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam",
                  ),
                );
              },
            ),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }
}

class FeedbackCard extends StatefulWidget {
  final String customerName;
  final int starRating;
  final String description;
  final int _maxRating = 5;

  const FeedbackCard({
    super.key,
    required this.customerName,
    required this.starRating,
    required this.description,
  });

  @override
  State<FeedbackCard> createState() => _FeedbackCardState();
}

class _FeedbackCardState extends State<FeedbackCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: kBorder),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.customerName,
                    style: GoogleFonts.yeonSung(
                      color: kTextPrimary,
                      fontSize: 15,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(widget._maxRating, (index) {
                      return Icon(
                        index < widget.starRating
                            ? Icons.star
                            : Icons.star_border,
                        color: kYellow,
                        size: 14,
                      );
                    }),
                  ),
                  Text(
                    widget.description,
                    style: GoogleFonts.yeonSung(
                      color: kTextPrimary,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
