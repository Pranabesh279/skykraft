import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skycraft/app/routes/app_pages.dart';

class AuthPhoneController extends GetxController {
  RxBool isChecked = false.obs;
  final fromKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();

  void continueClicked() {
    if (fromKey.currentState!.validate()) {
      Get.toNamed(
        Routes.AUTH_PHONE_VERIFY,
        arguments: {
          'phone': phoneController.text.trim(),
        },
      );
    }
  }
}
