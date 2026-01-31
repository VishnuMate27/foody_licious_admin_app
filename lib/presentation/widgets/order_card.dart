import 'package:flutter/material.dart';
import 'package:foody_licious_admin_app/core/constants/colors.dart';
import 'package:foody_licious_admin_app/core/utils/time_format_helper.dart';
import 'package:foody_licious_admin_app/domain/entities/order/order.dart';
import 'package:foody_licious_admin_app/domain/entities/order/orderMenuItem.dart';
import 'package:foody_licious_admin_app/presentation/widgets/container_chip.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderCard extends StatelessWidget {
  final String orderId;
  final DateTime orderCreatedAt;
  final String orderStatus;
  final String price;
  final String paymentMode;
  final String paymentStatus;
  final List<OrderMenuItem> items;
  final String customerName;
  final String customerAddress;
  final String customerPhone;
  final VoidCallback? onMoreButtonTap;
  final VoidCallback? onAcceptTap;
  final VoidCallback? onRejectTap;
  final VoidCallback? onMarkAsDispatchedTap;
  final VoidCallback? onPaymentAsReceivedTap;
  final VoidCallback? onMarkAsCancelledTap;
  final VoidCallback? onMarkAsDeliveredTap;

  const OrderCard.order({
    super.key,
    required this.orderId,
    required this.orderCreatedAt,
    required this.orderStatus,
    required this.price,
    required this.paymentMode,
    required this.paymentStatus,
    required this.items,
    required this.customerName,
    required this.customerAddress,
    required this.customerPhone,
    required this.onMoreButtonTap,
    required this.onAcceptTap,
    required this.onRejectTap,
    required this.onMarkAsDispatchedTap,
  }) : onMarkAsCancelledTap = null,
       onPaymentAsReceivedTap = null,
       onMarkAsDeliveredTap = null;

  const OrderCard.delivery({
    super.key,
    required this.orderId,
    required this.orderCreatedAt,
    required this.orderStatus,
    required this.price,
    required this.paymentMode,
    required this.paymentStatus,
    required this.items,
    required this.customerName,
    required this.customerAddress,
    required this.customerPhone,
    required this.onMoreButtonTap,
    required this.onPaymentAsReceivedTap,
    required this.onMarkAsDeliveredTap,
    required this.onMarkAsCancelledTap,
  }) : onMarkAsDispatchedTap = null,
       onAcceptTap = null,
       onRejectTap = null;

  const OrderCard.pastOrder({
    super.key,
    required this.orderId,
    required this.orderCreatedAt,
    required this.orderStatus,
    required this.price,
    required this.paymentMode,
    required this.paymentStatus,
    required this.items,
    required this.customerName,
    required this.customerAddress,
    required this.customerPhone,
    required this.onMoreButtonTap,
  }) : onPaymentAsReceivedTap = null,
       onMarkAsDeliveredTap = null,
       onMarkAsCancelledTap = null,
       onMarkAsDispatchedTap = null,
       onAcceptTap = null,
       onRejectTap = null;

  @override
  Widget build(BuildContext context) {
    if (orderStatus == OrderStatus.CONFIRMED.name) {
      return buildConfirmedContainer();
    } else if (orderStatus == OrderStatus.PREPARING.name) {
      return buildPreparingContainer();
    } else if (orderStatus == OrderStatus.DISPATCHED.name) {
      return buildDispatchedContainer();
    } else if (orderStatus == OrderStatus.DELIVERED.name ||
        orderStatus == OrderStatus.CANCELLED_BY_RESTAURANT.name) {
      return buildDeliveredContainer();
    } else {
      return Container();
    }
  }

  Widget buildConfirmedContainer() {
    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kTextRed, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: kBlack.withAlpha(40),
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Id, Time & more icon
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Id: $orderId',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.yeonSung(
                        color: kTextPrimary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(width: 40),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        TimeFormatHelper.formatTime(orderCreatedAt),
                        style: GoogleFonts.lato(
                          color: kTextPrimary,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      GestureDetector(
                        onTap: onMoreButtonTap,
                        child: const Icon(Icons.more_vert, size: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Gap
            SizedBox(height: 8),

            /// STATUS ROW
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ContainerChip(text: orderStatus),
                  ContainerChip(text: paymentMode, chipColor: kGreenish),
                ],
              ),
            ),

            /// Gap
            const SizedBox(height: 8),

            /// Divider
            Divider(color: kTextRed, thickness: 0.5),

            /// Gap
            const SizedBox(height: 8),
            // Item section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Items",
                    style: GoogleFonts.yeonSung(color: kBlack, fontSize: 22),
                  ),

                  /// Gap
                  const SizedBox(height: 8),

                  /// LIST
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final menuItem = items[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            menuItem.menuItemDetails.name,
                            style: GoogleFonts.yeonSung(
                              color: kBlack,
                              fontSize: 22,
                            ),
                          ),
                          Text(
                            "₹${menuItem.menuItemDetails.price}",
                            style: GoogleFonts.yeonSung(
                              color: kBlack,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  /// Gap
                  const SizedBox(height: 8),

                  /// Price Container
                  Container(
                    decoration: BoxDecoration(
                      color: kGreyBackground.withAlpha(102),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(width: 20),
                          Text(
                            "Price: ₹ $price",
                            style: GoogleFonts.yeonSung(
                              color: kBlack,
                              fontSize: 22,
                            ),
                          ),
                          ContainerChip(
                            text: paymentStatus,
                            chipColor: kYellow,
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// Gap
                  const SizedBox(height: 14),

                  // Accept Reject buttons
                  Row(
                    children: [
                      Expanded(
                        child: ContainerChip.button(
                          text: "REJECT",
                          onTap: onRejectTap,
                          width: null,
                          height: 36,
                          chipColor: kTextRed,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ContainerChip.button(
                          text: "ACCEPT",
                          onTap: onAcceptTap,
                          width: null,
                          height: 36,
                          chipColor: kGreenish,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// Gap
            const SizedBox(height: 8),

            /// Divider
            Divider(color: kTextRed, thickness: 0.5),

            /// Gap
            const SizedBox(height: 8),

            /// Customer Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Heading
                  Text(
                    "Customer Details:",
                    style: GoogleFonts.yeonSung(color: kBlack, fontSize: 22),
                  ),

                  /// Gap
                  const SizedBox(height: 8),

                  /// Details
                  Text(
                    "Name: $customerName\nAddress: $customerAddress\nPhone: $customerPhone",
                    style: GoogleFonts.yeonSung(color: kBlack, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPreparingContainer() {
    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kTextRed, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: kBlack.withAlpha(40),
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Id, Time & more icon
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Id: $orderId',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.yeonSung(
                        color: kTextPrimary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(width: 40),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${orderCreatedAt.hour}:${orderCreatedAt.minute}  AM',
                        style: GoogleFonts.lato(
                          color: kTextPrimary,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      GestureDetector(
                        onTap: onMoreButtonTap,
                        child: const Icon(Icons.more_vert, size: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Gap
            SizedBox(height: 8),

            /// STATUS ROW
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ContainerChip(text: orderStatus),
                  ContainerChip(text: paymentMode, chipColor: kGreenish),
                ],
              ),
            ),

            /// Gap
            const SizedBox(height: 8),

            /// Divider
            Divider(color: kTextRed, thickness: 0.5),

            /// Gap
            const SizedBox(height: 8),
            // Item section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Items",
                    style: GoogleFonts.yeonSung(color: kBlack, fontSize: 22),
                  ),

                  /// Gap
                  const SizedBox(height: 8),

                  /// LIST
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "3 X Tarri Poha",
                            style: GoogleFonts.yeonSung(
                              color: kBlack,
                              fontSize: 22,
                            ),
                          ),
                          Text(
                            "₹300",
                            style: GoogleFonts.yeonSung(
                              color: kBlack,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  /// Gap
                  const SizedBox(height: 8),

                  /// Price Container
                  Container(
                    decoration: BoxDecoration(
                      color: kGreyBackground.withAlpha(102),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(width: 20),
                          Text(
                            "Price: ₹ $price",
                            style: GoogleFonts.yeonSung(
                              color: kBlack,
                              fontSize: 22,
                            ),
                          ),
                          ContainerChip(
                            text: paymentStatus,
                            chipColor: kYellow,
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// Gap
                  const SizedBox(height: 14),

                  // Accept Reject buttons
                  ContainerChip.button(
                    text: "MARK AS DISPATCHED",
                    onTap: onMarkAsDispatchedTap,
                    width: null,
                    height: 36,
                    chipColor: kGreenish,
                  ),
                ],
              ),
            ),

            /// Gap
            const SizedBox(height: 8),

            /// Divider
            Divider(color: kTextRed, thickness: 0.5),

            /// Gap
            const SizedBox(height: 8),

            /// Customer Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Heading
                  Text(
                    "Customer Details:",
                    style: GoogleFonts.yeonSung(color: kBlack, fontSize: 22),
                  ),

                  /// Gap
                  const SizedBox(height: 8),

                  /// Details
                  Text(
                    "Name: $customerName\nAddress: $customerAddress\nPhone: $customerPhone",
                    style: GoogleFonts.yeonSung(color: kBlack, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDispatchedContainer() {
    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kTextRed, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: kBlack.withAlpha(40),
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Id, Time & more icon
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Id: $orderId',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.yeonSung(
                        color: kTextPrimary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(width: 40),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${orderCreatedAt.hour}:${orderCreatedAt.minute}  AM',
                        style: GoogleFonts.lato(
                          color: kTextPrimary,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      GestureDetector(
                        onTap: onMoreButtonTap,
                        child: const Icon(Icons.more_vert, size: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Gap
            SizedBox(height: 8),

            /// STATUS ROW
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ContainerChip(text: orderStatus),
                  ContainerChip(text: paymentMode, chipColor: kGreenish),
                ],
              ),
            ),

            /// Gap
            const SizedBox(height: 8),

            /// Divider
            Divider(color: kTextRed, thickness: 0.5),

            /// Gap
            const SizedBox(height: 8),
            // Item section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Items",
                    style: GoogleFonts.yeonSung(color: kBlack, fontSize: 22),
                  ),

                  /// Gap
                  const SizedBox(height: 8),

                  /// LIST
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "3 X Tarri Poha",
                            style: GoogleFonts.yeonSung(
                              color: kBlack,
                              fontSize: 22,
                            ),
                          ),
                          Text(
                            "₹300",
                            style: GoogleFonts.yeonSung(
                              color: kBlack,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  /// Gap
                  const SizedBox(height: 8),

                  /// Price Container
                  Container(
                    decoration: BoxDecoration(
                      color: kGreyBackground.withAlpha(102),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(width: 20),
                          Text(
                            "Price: ₹ $price",
                            style: GoogleFonts.yeonSung(
                              color: kBlack,
                              fontSize: 22,
                            ),
                          ),
                          ContainerChip(
                            text: paymentStatus,
                            chipColor: kYellow,
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// Gap
                  const SizedBox(height: 14),

                  // Mark Payment as Received buttons
                  ContainerChip.button(
                    text: "MARK PAYMENT AS RECEIVED",
                    onTap: onPaymentAsReceivedTap,
                    width: null,
                    height: 36,
                    chipColor: kGreenish,
                  ),

                  /// Gap
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      // Mark as Cancelled buttons
                      Expanded(
                        child: ContainerChip.button(
                          text: "MARK AS CANCELED",
                          onTap: onMarkAsCancelledTap,
                          width: null,
                          height: 36,
                          chipColor: kTextRed,
                        ),
                      ),

                      /// Gap
                      const SizedBox(width: 10),

                      // Mark as Delivered buttons
                      Expanded(
                        child: ContainerChip.button(
                          text: "MARK AS DELIVERED",
                          onTap: onMarkAsDeliveredTap,
                          width: null,
                          height: 36,
                          chipColor: kGreenish,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// Gap
            const SizedBox(height: 8),

            /// Divider
            Divider(color: kTextRed, thickness: 0.5),

            /// Gap
            const SizedBox(height: 8),

            /// Customer Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Heading
                  Text(
                    "Customer Details:",
                    style: GoogleFonts.yeonSung(color: kBlack, fontSize: 22),
                  ),

                  /// Gap
                  const SizedBox(height: 8),

                  /// Details
                  Text(
                    "Name: $customerName\nAddress: $customerAddress\nPhone: $customerPhone",
                    style: GoogleFonts.yeonSung(color: kBlack, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDeliveredContainer() {
    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kTextRed, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: kBlack.withAlpha(40),
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Id, Time & more icon
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Id: $orderId',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.yeonSung(
                        color: kTextPrimary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(width: 40),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${orderCreatedAt.hour}:${orderCreatedAt.minute}  AM',
                        style: GoogleFonts.lato(
                          color: kTextPrimary,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      GestureDetector(
                        onTap: onMoreButtonTap,
                        child: const Icon(Icons.more_vert, size: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Gap
            SizedBox(height: 8),

            /// STATUS ROW
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ContainerChip(text: orderStatus),
                  ContainerChip(text: paymentMode, chipColor: kGreenish),
                ],
              ),
            ),

            /// Gap
            const SizedBox(height: 8),

            /// Divider
            Divider(color: kTextRed, thickness: 0.5),

            /// Gap
            const SizedBox(height: 8),
            // Item section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Items",
                    style: GoogleFonts.yeonSung(color: kBlack, fontSize: 22),
                  ),

                  /// Gap
                  const SizedBox(height: 8),

                  /// LIST
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "3 X Tarri Poha",
                            style: GoogleFonts.yeonSung(
                              color: kBlack,
                              fontSize: 22,
                            ),
                          ),
                          Text(
                            "₹300",
                            style: GoogleFonts.yeonSung(
                              color: kBlack,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  /// Gap
                  const SizedBox(height: 8),

                  /// Price Container
                  Container(
                    decoration: BoxDecoration(
                      color: kGreyBackground.withAlpha(102),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(width: 20),
                          Text(
                            "Price: ₹ $price",
                            style: GoogleFonts.yeonSung(
                              color: kBlack,
                              fontSize: 22,
                            ),
                          ),
                          ContainerChip(
                            text: paymentStatus,
                            chipColor: kYellow,
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// Gap
                  const SizedBox(height: 8),
                ],
              ),
            ),

            /// Gap
            const SizedBox(height: 8),

            /// Divider
            Divider(color: kTextRed, thickness: 0.5),

            /// Gap
            const SizedBox(height: 8),

            /// Customer Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Heading
                  Text(
                    "Customer Details:",
                    style: GoogleFonts.yeonSung(color: kBlack, fontSize: 22),
                  ),

                  /// Gap
                  const SizedBox(height: 8),

                  /// Details
                  Text(
                    "Name: $customerName\nAddress: $customerAddress\nPhone: $customerPhone",
                    style: GoogleFonts.yeonSung(color: kBlack, fontSize: 16),
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
