import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious_admin_app/core/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class DeliveryView extends StatefulWidget {
  const DeliveryView({super.key});

  @override
  State<DeliveryView> createState() => _DeliveryViewState();
}

class _DeliveryViewState extends State<DeliveryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Out For Delivery",
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
                  child: DeliveryCard(
                    customerName: "Customer Name",
                    paymentStatus: "Received",
                    deliveryStatus: "Delivered",
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

class DeliveryCard extends StatefulWidget {
  final String customerName;
  final String paymentStatus;
  final String deliveryStatus;

  DeliveryCard({
    super.key,
    required this.customerName,
    required this.paymentStatus,
    required this.deliveryStatus,
  });

  @override
  State<DeliveryCard> createState() => _DeliveryCardState();
}

class _DeliveryCardState extends State<DeliveryCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 102.h,
        padding: EdgeInsets.only(top: 14.w, bottom: 14.w, left: 24.w),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.customerName,
                    style: GoogleFonts.yeonSung(
                      color: kTextPrimary,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    "payment",
                    style: GoogleFonts.lato(
                      color: kTextOnPrimary,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "${widget.paymentStatus}",
                    style: GoogleFonts.lato(
                      color:
                          widget.paymentStatus == "Received"
                              ? kGreen
                              : kTextRed,
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.deliveryStatus,
                    style: GoogleFonts.lato(color: kTextPrimary, fontSize: 16),
                  ),
                  Icon(
                    Icons.circle,
                    size: 34,
                    color:
                        widget.deliveryStatus == "Delivered"
                            ? kGreen
                            : kPrimaryRed,
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
