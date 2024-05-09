import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skycraft/app/constants/constants.dart';
import 'package:skycraft/app/models/auth/user_model.dart';
import 'package:skycraft/app/models/bookings/booking_mlodel.dart';
import 'package:skycraft/app/modules/booking_list/controllers/booking_list_controller.dart';
import 'package:skycraft/app/providers/users_provider.dart';
import 'package:skycraft/app/utils/utils.dart';
import 'package:skycraft/app/widgets/buttons/gradient_button.dart';
import 'package:skycraft/app/widgets/card.dart';
import 'package:skycraft/app/widgets/profile_image.dart';

class BookingCard extends GetView<BookingListController> {
  final BookingModel booking;
  final String curentUserRole;
  const BookingCard(
      {super.key, required this.booking, required this.curentUserRole});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // booking id
          Row(
            children: [
              const Text(
                'Booking ID: ',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              Text(
                sortUuid(booking.id ?? ''),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: StreamBuilder<UserModel?>(
                    stream: Get.find<UserProvider>().userStream(
                        curentUserRole == UserRole.client
                            ? booking.dronUserId ?? ''
                            : booking.userId ?? ''),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                        );
                      }
                      if (snapshot.data == null) {
                        return Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                        );
                      }
                      return Row(
                        children: [
                          ProfileImage(
                            name: snapshot.data?.name ?? '',
                            userRole: snapshot.data?.role ?? '',
                            size: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (snapshot.data?.role ?? '').capitalizeFirst ??
                                    '',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                snapshot.data?.name ?? '',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: BookingStatusColors(booking.bookingStatus!)
                      .color
                      .withOpacity(0.16),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  (booking.bookingStatus ?? '').capitalizeFirst ?? '',
                  style: TextStyle(
                    color: BookingStatusColors(booking.bookingStatus!).color,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          // location
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                CupertinoIcons.location,
                color: Colors.grey,
                size: 16,
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.serviceLocationId.city ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      booking.serviceLocationId.address ?? '',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (curentUserRole == UserRole.client &&
              (booking.bookingStatus == BookingStatus.accepted)) ...[
            Divider(
              color: Colors.grey[200],
              thickness: 1,
            ),
            // completed botton
            Obx(() => SizedBox(
                  height: 40,
                  child: GradientButton(
                      isLoading: controller.isCompleteLoading.value,
                      onPressed: () {
                        controller.completeBooking(
                          booking.id ?? '',
                          pilotId: booking.dronUserId!,
                          totalAmount: booking.totalAmount!,
                        );
                      },
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Text(
                        'Completed',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                )),
          ],
          if (curentUserRole == UserRole.dronePilot) ...[
            Divider(
              color: Colors.grey[200],
              thickness: 1,
            ),
            const Text(
              'Requested Booking Dates',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                runAlignment: WrapAlignment.start,
                children: booking.bookingDates
                    .map((e) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          margin: const EdgeInsets.only(right: 5, bottom: 5),
                          child: Text(
                            DateFormat('MMM dd yyyy').format(e.toDate()),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ))
                    .toList()),
            // amout paid - remove platfrom fee 10% from the total amount
            const SizedBox(
              height: 10,
            ),
            const Text('Billing Amount', style: TextStyle(fontSize: 12)),
            Row(
              children: [
                Image.asset(
                  'assets/icons/coins.png',
                  height: 20,
                  width: 20,
                ),
                Text(
                  '${booking.totalAmount ?? 0}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                // you can add the platform fee here  - 10% of the total amount
                Text(
                  ' (-${(booking.totalAmount ?? 0) * 0.1})',
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                Image.asset(
                  'assets/icons/coins.png',
                  height: 20,
                  width: 20,
                ),
                Text(
                  '+ ${(booking.totalAmount ?? 0) - (booking.totalAmount ?? 0) * 0.1}',
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            if (controller.isShowButtonSegment(booking.bookingStatus!) &&
                booking.bookingStatus != BookingStatus.completed)
              Divider(
                color: Colors.grey[200],
                thickness: 1,
              ),
            // aceopt or reject
            if (controller.isShowButtonSegment(booking.bookingStatus!) &&
                booking.bookingStatus != BookingStatus.completed)
              Obx(() => SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        Expanded(
                          child: GradientButton(
                              isLoading: controller.isAcceptLoading.value,
                              onPressed: () {
                                controller.acceptBooking(booking.id ?? '');
                              },
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: const Text(
                                'Accept',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: GradientButton(
                            isLoading: controller.isRejectLoading.value,
                            color: Colors.red,
                            onPressed: () {
                              controller.rejectBooking(booking.id ?? '');
                            },
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: const Text(
                              'Reject',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
          ],
        ],
      ),
    );
  }
}
