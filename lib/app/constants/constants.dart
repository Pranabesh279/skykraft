import 'package:flutter/material.dart';

class UserRole {
  static const String admin = 'admin';
  static const String client = 'client';
  static const String dronePilot = 'pilot';
}

class WalletStatus {
  static const String credit = 'credit';
  static const String debit = 'debit';
}

class BookingStatus {
  static const String pending = 'pending';
  static const String onGoing = 'onGoing';
  static const String accepted = 'accepted';
  static const String rejected = 'rejected';
  static const String completed = 'completed';
}

class BookingStatusColors {
  final String status;
  BookingStatusColors(this.status);
  Color get color {
    switch (status) {
      case BookingStatus.pending:
        return Colors.orange;
      case BookingStatus.onGoing:
        return Colors.blue;
      case BookingStatus.accepted:
        return Colors.green;
      case BookingStatus.rejected:
        return Colors.red;
      case BookingStatus.completed:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}

class BookingType {
  static const String normal = 'normal';
  static const String instant = 'instant';
}
