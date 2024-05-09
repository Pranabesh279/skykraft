import 'dart:developer';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skycraft/app/constants/constants.dart';
import 'package:skycraft/app/constants/level_const.dart';
import 'package:skycraft/app/constants/theme_data.dart';
import 'package:skycraft/app/models/addresss_data.dart';
import 'package:skycraft/app/models/auth/user_model.dart';
import 'package:skycraft/app/models/bookings/booking_mlodel.dart';
import 'package:skycraft/app/providers/auth_provider.dart';
import 'package:skycraft/app/providers/booking_provider.dart';
import 'package:skycraft/app/providers/post_provider.dart';
import 'package:skycraft/app/providers/wallet_provider.dart';
import 'package:skycraft/app/routes/app_pages.dart';

class CreateBookingController extends GetxController {
  final UserModel? user;
  CreateBookingController({this.user});
  RxBool isLoading = false.obs;
  RxList<DateTime?> selectedDates = <DateTime?>[].obs;
  Rx<AddressData?> fromAddress = Rx<AddressData?>(null);
  Rx<int?> userPostCount = 0.obs;
  Rx<double> coins = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    getWalletBalance();
    userPostCount.bindStream(
        Get.find<PostProvider>().getPostsCountStreamByUser(user!.uid!));
  }

  void getWalletBalance() async {
    String uid = Get.find<AuthProvider>().userModel.value!.uid!;

    coins.bindStream(Get.find<WalletProvider>().walletStream(uid));
  }

  int get getBookingPrice {
    int postCount = userPostCount.value ?? 0;
    int pricePerDay = UserLevel(postCount: postCount).priceByLevel;
    return selectedDates.length * pricePerDay;
  }

  Future createBooking() async {
    isLoading.value = true;

    try {
      String uid = Get.find<AuthProvider>().userModel.value!.uid!;
      BookingModel booking = BookingModel(
        userId: uid,
        bookingDates: selectedDates.map((e) => getTimeStamp(e!)).toList(),
        bookingStatus: BookingStatus.pending,
        serviceLocationId: fromAddress.value!,
        totalAmount: getBookingPrice.toDouble(),
        startOtp: getFourDigitRandomNumber().toString(),
        endOtp: getFourDigitRandomNumber().toString(),
        dronUserId: user!.uid!,
        bookingType: BookingType.normal,
      );
      final bookingId =
          await Get.find<BookingProvider>().createBooking(booking.toMap());
      Get.snackbar(
        'Success',
        'Booking created successfull',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
        colorText: Colors.white,
        backgroundColor: kPrimary,
      );
      Get.offAllNamed(Routes.DASHBOARD);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to create booking',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        colorText: Colors.white,
        backgroundColor: kPrimary,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Timestamp getTimeStamp(DateTime date) {
    return Timestamp.fromDate(date);
  }

  int getFourDigitRandomNumber() {
    final randomFourDigit = 1000 + Random().nextInt(9999 - 1000);
    return randomFourDigit;
  }
}
