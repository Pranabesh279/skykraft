import 'dart:developer';

import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:skycraft/app/routes/app_pages.dart';

class LocationPermissionController extends GetxController {
  RxBool isLoading = false.obs;
  Location location = Location();
  RxBool isLocationserviceEnabled = false.obs;
  RxBool isLocationPermissionGranted = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkPermission();
  }

  void checkPermission() async {
    isLocationserviceEnabled.value = await location.serviceEnabled();
    await location.hasPermission() == PermissionStatus.granted
        ? isLocationPermissionGranted.value = true
        : isLocationPermissionGranted.value = false;
  }

  void allowPermission() async {
    isLoading.value = true;
    try {
      if (isLocationserviceEnabled.value == false) {
        await location.requestService();
      }
      await location.requestPermission();
      checkPermission();
      await LocationService.checkLocationPermission().then((v) {
        if (v) {
          Get.offAllNamed(AppPages.MAIN);
        } else {
          Get.snackbar('Permission Denied', 'Please allow location permission');
        }
      });
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

class LocationService {
  static Future<bool> checkLocationPermission() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      return false;
    }
    return true;
  }
}
