import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/booking_details_controller.dart';

class BookingDetailsView extends GetView<BookingDetailsController> {
  const BookingDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BookingDetailsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BookingDetailsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
