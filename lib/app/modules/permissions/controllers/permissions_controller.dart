import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:skycraft/app/providers/auth_provider.dart';
import 'package:skycraft/app/routes/app_pages.dart';

class PermissionsController extends GetxController {
  RxBool isLoading = false.obs;

  checkPer() async {
    try {
      bool p = await checkPermission();
      if (p) {
        Get.offAllNamed(Routes.DASHBOARD);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> requestLocationPermission() async {
    isLoading.value = true;
    // bool loP = await determinePosition();
    // if (!loP) {
    //   return;
    // }
    isLoading.value = false;
  }

  Future<void> determinePosition() async {
    isLoading.value = true;
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    log(locationData.latitude.toString(), name: 'latitude');
    log(locationData.longitude.toString(), name: 'longitude');
    AuthProvider authController = Get.find<AuthProvider>();

    await authController.updateUserLocation(authController.user.value!.uid,
        geoPoint: GeoPoint(locationData.latitude!, locationData.longitude!));
    isLoading.value = false;
    // bool serviceEnabled;
    // LocationPermission permission;
    // serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   Get.bottomSheet(
    //     Container(
    //       decoration: BoxDecoration(
    //         color: Get.theme.scaffoldBackgroundColor,
    //         borderRadius: const BorderRadius.only(
    //           topLeft: Radius.circular(20),
    //           topRight: Radius.circular(20),
    //         ),
    //       ),
    //       padding: const EdgeInsets.all(20),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           const Text(
    //             'Location service disabled',
    //             style: TextStyle(
    //               fontSize: 20,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //           const SizedBox(height: 10),
    //           const Text(
    //             'Please enable location service to continue',
    //             style: TextStyle(
    //               fontSize: 16,
    //             ),
    //           ),
    //           const SizedBox(height: 20),
    //           GradientButton(
    //             child: const Text(
    //               'Get',
    //               style: TextStyle(color: Colors.white),
    //             ),
    //             onPressed: () async {
    //               final b = await Geolocator.openLocationSettings();
    //               if (b) {
    //                 Get.back();
    //               }
    //             },
    //           )
    //         ],
    //       ),
    //     ),
    //     isDismissible: false,
    //     enableDrag: false,
    //   );
    // }
    // permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.denied) {
    //     Get.bottomSheet(
    //       Container(
    //         decoration: BoxDecoration(
    //           color: Get.theme.scaffoldBackgroundColor,
    //           borderRadius: const BorderRadius.only(
    //             topLeft: Radius.circular(20),
    //             topRight: Radius.circular(20),
    //           ),
    //         ),
    //         padding: const EdgeInsets.all(20),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             const Text(
    //               'Location permission denied',
    //               style: TextStyle(
    //                 fontSize: 20,
    //                 fontWeight: FontWeight.bold,
    //               ),
    //             ),
    //             const SizedBox(height: 10),
    //             const Text(
    //               'Please enable location permission to continue',
    //               style: TextStyle(
    //                 fontSize: 16,
    //               ),
    //             ),
    //             const SizedBox(height: 20),
    //             GradientButton(
    //               child: const Text(
    //                 'Get',
    //                 style: TextStyle(color: Colors.white),
    //               ),
    //               onPressed: () async {
    //                 final b = await Geolocator.openAppSettings();
    //                 if (b) {
    //                   Get.back();
    //                 }
    //               },
    //             )
    //           ],
    //         ),
    //       ),
    //       isDismissible: false,
    //       enableDrag: false,
    //     );
    //   }
    // }
    // if (permission == LocationPermission.deniedForever) {
    //   Get.bottomSheet(
    //     Container(
    //       decoration: BoxDecoration(
    //         color: Get.theme.scaffoldBackgroundColor,
    //         borderRadius: const BorderRadius.only(
    //           topLeft: Radius.circular(20),
    //           topRight: Radius.circular(20),
    //         ),
    //       ),
    //       padding: const EdgeInsets.all(20),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           const Text(
    //             'Location permission denied forever',
    //             style: TextStyle(
    //               fontSize: 20,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //           const SizedBox(height: 10),
    //           const Text(
    //             'Please enable location permission to continue',
    //             style: TextStyle(
    //               fontSize: 16,
    //             ),
    //           ),
    //           const SizedBox(height: 20),
    //           GradientButton(
    //             child: const Text(
    //               'Get',
    //               style: TextStyle(color: Colors.white),
    //             ),
    //             onPressed: () async {
    //               final b = await Geolocator.openAppSettings();
    //               if (b) {
    //                 Get.back();
    //               }
    //             },
    //           )
    //         ],
    //       ),
    //     ),
    //     isDismissible: false,
    //     enableDrag: false,
    //   );
    // }
  }

  Future<bool> checkPermission() async {
    // Location location = Location();
    bool serviceEnabled = false;
    // serviceEnabled = await location.serviceEnabled();
    return serviceEnabled;
  }
}
