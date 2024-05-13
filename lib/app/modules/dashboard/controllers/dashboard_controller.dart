import 'package:get/get.dart';

import 'package:flutter/foundation.dart' as foundation;

class DashboardController extends GetxController {
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
}
