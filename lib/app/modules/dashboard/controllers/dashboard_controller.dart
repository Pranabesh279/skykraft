import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:get/get.dart';

import 'package:flutter/foundation.dart' as foundation;
import 'package:location/location.dart';
import 'package:skycraft/app/models/auth/user_model.dart';
import 'package:skycraft/app/providers/auth_provider.dart';

class DashboardController extends GetxController {
  late Location location;
  Rx<UserModel?> userData = Rx<UserModel?>(null);
  AuthProvider authProvider = Get.find<AuthProvider>();

  @override
  void onInit() {
    super.onInit();
    getUser();
    ever(authProvider.userModel, (callback) => getUser());
    // ever(userData, (callback) => updatePosition());
  }

  getUser({String? uid}) {
    userData.value = authProvider.userModel.value;
    if (userData.value?.location != null) {
      location = Location();
      updatePosition(userData.value?.location);
    }
  }

  Rx<int> selectedIndex = 0.obs;
  bool get isIos =>
      foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS;
  List<String> icons = [
    'assets/icons/tabler_home.png',
    // 'assets/icons/iconamoon_discover-light.png',
    // 'assets/icons/typcn_flash-outline.png',
    'assets/icons/gg_profile.png',
  ];
  final List<GetPage> _getPages = [];
  List<GetPage> get pages => _getPages;

  void changePage(int index) {
    selectedIndex.value = index;
  }

  String onGenerateIcon(int index) {
    return icons[index];
  }

  void updatePosition(GeoPoint? curentlocation) {
    location.onLocationChanged.listen((LocationData currentLocation) async {
      // Use current
      log('Location updated ${currentLocation.latitude} ${currentLocation.longitude}',
          name: 'Location');
      bool isSameLocation =
          curentlocation!.latitude == currentLocation.latitude &&
              curentlocation.longitude == currentLocation.longitude;
      if (!isSameLocation) {
        authProvider.updateUserLocation(userData.value!.uid!,
            geoPoint: GeoPoint(
                currentLocation.latitude!, currentLocation.longitude!));
      }
    });
  }
}
