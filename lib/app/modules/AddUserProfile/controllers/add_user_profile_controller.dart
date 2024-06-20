import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skycraft/app/providers/auth_provider.dart';
import 'package:skycraft/app/routes/app_pages.dart';
import 'package:skycraft/app/service/storage_service.dart';

class AddUserProfileController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Rx<bool> isLoading = false.obs;
  Rx<File?> imageFile = Rx<File?>(null);
  final fromKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  final AuthProvider _auth = Get.find<AuthProvider>();
  Rx<String?> avatarUrlError = Rx<String?>(null);

  void submit() async {
    if (imageFile.value == null) {
      avatarUrlError.value = 'Please select an image';
      return;
    } else {
      avatarUrlError.value = null;
    }
    if (fromKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        Map<String, dynamic> data = await payload();
        await _firestore
            .collection('users')
            .doc(_auth.userModel.value!.uid)
            .update(data);
        await _auth.updateUserData(_auth.userModel.value!.uid!);
        isLoading.value = false;
        Get.offAllNamed(Routes.SET_USER_ROLE);
      } catch (err) {
        isLoading.value = false;
        Get.snackbar('Error', err.toString());
      }
    }
  }

  Future<Map<String, dynamic>> payload() async {
    final photoUrl = await StorageBucketService.uploadAndGetDownloadUrl(
        imageFile.value!,
        path: 'profile/${_auth.userModel.value!.uid}');
    final uesername = _auth.userModel.value!.uid!.substring(0, 5) +
        nameController.text.substring(0, 5);
    Map<String, dynamic> data = {
      'name': nameController.text,
      'username': uesername,
      'photoUrl': photoUrl,
    };
    return data;
  }
}
