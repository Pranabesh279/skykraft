import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:skycraft/app/modules/booking_list/widgets/booking_card.dart';

import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

import '../controllers/booking_list_controller.dart';

class BookingListView extends GetView<BookingListController> {
  const BookingListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SuperScaffold(
        appBar: SuperAppBar(
          height: 40,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          largeTitle: SuperLargeTitle(
            largeTitle: 'Your Bookings',
            textStyle: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          leading: TextButton.icon(
            icon: Icon(
              CupertinoIcons.back,
              color: Theme.of(context).primaryColor,
              size: 20,
            ),
            onPressed: () {
              Get.back();
            },
            label: Text('Back',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                )),
          ),
          title: Text('Your Bookings',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              )),
          searchBar: SuperSearchBar(
            enabled: false,
            onChanged: (value) {
              controller.search.value = value;
            },
          ),
        ),
        body: Obx(
          () => controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: controller.bookings.length,
                  itemBuilder: (context, index) {
                    final booking = controller.bookings[index];
                    return BookingCard(
                      booking: booking,
                      curentUserRole: controller.curentUserRole,
                    );
                  },
                ),
        ),
      ),
    );
  }
}
