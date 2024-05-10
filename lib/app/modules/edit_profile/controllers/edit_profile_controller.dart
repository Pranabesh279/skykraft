import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skycraft/app/models/auth/user_model.dart';
import 'package:skycraft/app/providers/auth_provider.dart';

class EditProfileController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<UserModel?> user = Rx<UserModel?>(null);
  AuthProvider authProvider = Get.find<AuthProvider>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  getUserData() async {
    isLoading.value = true;
    String userId = authProvider.userModel.value?.uid ?? '';
    log(userId, name: 'userId');
    user.value = await authProvider.getUserDetails(userId);
    updateUserUiData(user.value!);
    isLoading.value = false;
  }

  void updateUserUiData(UserModel user) {
    usernameController.text = user.name ?? '';
    emailController.text = user.email ?? '';
    phoneNumberController.text = user.phone ?? '';
  }

  void updateUser() async {
    isLoading.value = true;
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneNumberController.text.isEmpty) {
      Get.snackbar('Error', 'All fields are required');
      isLoading.value = false;
      return;
    }
    Map<String, dynamic> updatedUserData = {
      'name': usernameController.text,
      'email': emailController.text,
      'phone': phoneNumberController.text,
    };
    await authProvider.updateUser(user.value!.uid!, data: updatedUserData);
    getUserData();
    isLoading.value = false;
  }
}
