import 'dart:developer';

import 'package:get/get.dart';
import 'package:skycraft/app/modules/locationPermission/controllers/location_permission_controller.dart';
import 'package:skycraft/app/providers/auth_provider.dart';
import 'package:skycraft/app/routes/app_pages.dart';

class SplashController extends GetxController {
  Rx<bool> isLoading = true.obs;
  final AuthProvider _auth = Get.find<AuthProvider>();

  @override
  void onInit() {
    super.onInit();
    log('SplashController started', name: 'Splash');
    Future.delayed(const Duration(seconds: 3), () async {
      isLoading.value = false;
      if (_auth.userModel.value != null) {
        if (_auth.userModel.value!.photoUrl == null) {
          Get.offAllNamed(Routes.ADD_USER_PROFILE);
          return;
        }
        if (_auth.userModel.value!.name == null) {
          Get.offAllNamed(Routes.ADD_USER_PROFILE);
          return;
        }
        if (_auth.userModel.value!.role == null) {
          Get.offAllNamed(Routes.SET_USER_ROLE);
          return;
        }
        bool isLocationPermission =
            await LocationService.checkLocationPermission();
        if (isLocationPermission) {
          Get.offAllNamed(AppPages.MAIN);
        } else {
          Get.offAllNamed(Routes.LOCATION_PERMISSION);
        }
      } else {
        Get.offAllNamed(Routes.AUTH_PHONE);
      }
    });
  }
}
