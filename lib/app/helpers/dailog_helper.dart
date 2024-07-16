import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogHelper {
  //show error dialog
  static void showErroDialog(
      {String title = 'Error', String? description = 'Something went wrong'}) {
    Get.dialog(
      Dialog(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Get.textTheme.headlineMedium,
              ),
              Text(
                description ?? '',
                style: Get.textTheme.titleLarge,
              ),
              ElevatedButton(
                onPressed: () {
                  if (Get.isDialogOpen!) Get.back();
                },
                child: const Text('Okay'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //show toast
  //show snack bar
  //show loading
  static void showLoading([String? message]) {
    Get.dialog(
      Dialog(
        insetPadding: EdgeInsets.zero,
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0.15),
        child: Container(
          height: MediaQuery.of(Get.context!).size.height,
          width: MediaQuery.of(Get.context!).size.width,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              if (message != null) ...[
                const SizedBox(height: 8),
                Text(message),
              ],
            ],
          ),
        ),
      ),
    );
  }

  //hide loading
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }
}
