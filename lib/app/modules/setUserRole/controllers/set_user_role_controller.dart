import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:skycraft/app/constants/constants.dart';
import 'package:skycraft/app/providers/auth_provider.dart';
import 'package:skycraft/app/providers/wallet_provider.dart';
import 'package:skycraft/app/routes/app_pages.dart';

class SetUserRoleController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Rx<bool> isLoading = false.obs;
  Rx<String?> userRole = Rx<String?>(UserRole.client);
  final AuthProvider _auth = Get.find<AuthProvider>();
  final WalletProvider _wallet = Get.find<WalletProvider>();

  void submit() async {
    isLoading.value = true;
    try {
      Map<String, dynamic> data = await payload();
      await _firestore
          .collection('users')
          .doc(_auth.userModel.value!.uid)
          .update(data);
      await _auth.updateUserData(_auth.userModel.value!.uid!);
      isLoading.value = false;
      Get.offAllNamed(AppPages.MAIN);
    } catch (err) {
      isLoading.value = false;
      Get.snackbar('Error', err.toString());
    }
  }

  Future<Map<String, dynamic>> payload() async {
    final walletId = await _wallet.createWallet(_auth.userModel.value!.uid!);

    Map<String, dynamic> data = {
      'role': userRole.value,
      'walletId': walletId,
    };
    if (userRole.value == UserRole.client) {}
    if (userRole.value == UserRole.dronePilot) {
      data['certificate_path'] = null;
    }
    log('Payload $data', name: 'SetUserRoleController');
    return data;
  }
}
