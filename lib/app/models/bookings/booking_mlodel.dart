import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skycraft/app/models/addresss_data.dart';

class BookingModel {
  final String? id;
  final String? userId;
  final List<Timestamp> bookingDates;
  final String? bookingStatus;
  final String? dronUserId;
  final double? totalAmount;
  final AddressData serviceLocationId;
  final String startOtp;
  final String endOtp;
  final String bookingType;

  BookingModel({
    this.id,
    this.userId,
    required this.bookingDates,
    this.bookingStatus,
    this.dronUserId,
    this.totalAmount,
    required this.serviceLocationId,
    required this.startOtp,
    required this.endOtp,
    required this.bookingType,
  });

  factory BookingModel.fromMap(Map<String, dynamic> data, String documentId) {
    final List<Timestamp> bookingDates = (data['bookingDates'] as List)
        .map((e) => Timestamp.fromMillisecondsSinceEpoch(e.seconds * 1000))
        .toList();
    return BookingModel(
      id: documentId,
      userId: data['userId'],
      bookingDates: bookingDates,
      bookingStatus: data['bookingStatus'],
      dronUserId: data['dronUserId'],
      totalAmount: data['totalAmount'],
      serviceLocationId: AddressData.fromMap(data['serviceLocationId']),
      startOtp: data['startOtp'],
      endOtp: data['endOtp'],
      bookingType: data['bookingType'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'bookingDates': bookingDates,
      'bookingStatus': bookingStatus,
      'dronUserId': dronUserId,
      'serviceLocationId': serviceLocationId.toMap(),
      'startOtp': startOtp,
      'endOtp': endOtp,
      'totalAmount': totalAmount,
      'bookingType': bookingType,
    };
  }

  // from Snap
  factory BookingModel.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    final List<Timestamp> bookingDates = (snapshot['bookingDates'] as List)
        .map((e) => Timestamp.fromMillisecondsSinceEpoch(e.seconds * 1000))
        .toList();
    return BookingModel(
      id: snap.id,
      userId: snapshot['userId'],
      bookingDates: bookingDates,
      bookingStatus: snapshot['bookingStatus'],
      dronUserId: snapshot['dronUserId'],
      totalAmount: snapshot['totalAmount'],
      serviceLocationId: AddressData.fromMap(snapshot['serviceLocationId']),
      startOtp: snapshot['startOtp'],
      endOtp: snapshot['endOtp'],
      bookingType: snapshot['bookingType'],
    );
  }
}
