import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:skycraft/app/constants/constants.dart';
import 'package:skycraft/app/models/bookings/booking_mlodel.dart';
// import 'package:skycraft/app/providers/wallet_provider.dart';

class BookingProvider extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> createBooking(Map<String, dynamic> map) async {
    try {
      Map<String, dynamic> data = map;
      data['createdAt'] = FieldValue.serverTimestamp();
      CollectionReference booking = _firestore.collection('bookings');
      final bookingId = await booking.add(data);
      // if (bookingId.id.isNotEmpty) {
      //   await Get.find<WalletProvider>().deductWallet(
      //       data['userId'], data['totalAmount'],
      //       refId: bookingId.id, refType: 'bookings');
      // }
      log(bookingId.id, name: 'bookingId');
      return bookingId.id;
    } catch (e) {
      return null;
    }
  }

  Future<bool> updateBooking(String bookingId, Map<String, dynamic> map) async {
    try {
      Map<String, dynamic> data = map;
      map['updatedAt'] = FieldValue.serverTimestamp();
      CollectionReference booking = _firestore.collection('bookings');
      await booking.doc(bookingId).update(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteBooking(String bookingId) async {
    try {
      CollectionReference booking = _firestore.collection('bookings');
      await booking.doc(bookingId).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<BookingModel>> getBookings(String userId,
      {required String userRole}) async {
    try {
      log("$userId $userRole", name: "getBookings");
      CollectionReference booking = _firestore.collection('bookings');
      final bookings = userRole == UserRole.client
          ? await booking
              .where('userId', isEqualTo: userId)
              // .orderBy('createdAt', descending: true)
              .get()
          : await booking
              .where('dronUserId', isEqualTo: userId)
              // .orderBy('createdAt', descending: true)
              .get();
      return bookings.docs.map((e) => BookingModel.fromSnap(e)).toList();
    } catch (e) {
      log(e.toString(), name: "getBookings" "error");
      return [];
    }
  }

  Stream<List<BookingModel>> getBookingsStream(String userId,
      {required String userRole}) {
    log("$userId $userRole", name: "getBookingsStream");
    CollectionReference booking = _firestore.collection('bookings');
    return userRole == UserRole.client
        ? booking
            .where('userId', isEqualTo: userId)
            // .orderBy('createdAt', descending: true)
            .snapshots()
            .map((event) =>
                event.docs.map((e) => BookingModel.fromSnap(e)).toList())
        : booking
            .where('dronUserId', isEqualTo: userId)
            // .orderBy('createdAt', descending: true)
            .snapshots()
            .map((event) =>
                event.docs.map((e) => BookingModel.fromSnap(e)).toList());
  }
}
