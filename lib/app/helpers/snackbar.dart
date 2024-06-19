import 'package:flutter/material.dart';

import 'package:get/get.dart';

enum SnackbarType {
  success,
  error,
  warning,
  info,
}

snackbar({
  required String title,
  required String message,
  required SnackbarType type,
  SnackPosition position = SnackPosition.TOP,
  Color? color,
}) =>
    Get.snackbar(
      '',
      '',
      icon: Icon(
        type == SnackbarType.success
            ? Icons.check_circle
            : type == SnackbarType.error
                ? Icons.error
                : type == SnackbarType.warning
                    ? Icons.warning
                    : Icons.info,
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      titleText: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
      backgroundColor: Colors.black,
      colorText: Colors.white,
      snackStyle: SnackStyle.FLOATING,
      snackPosition: position,
    );
