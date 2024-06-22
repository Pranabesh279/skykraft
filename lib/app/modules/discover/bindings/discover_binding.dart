import 'dart:io';

import 'package:get/get.dart';

import '../controllers/discover_controller.dart';

class DiscoverBinding extends Bindings {
  final File? imageFile;
  DiscoverBinding({this.imageFile});

  @override
  void dependencies() {
    Get.lazyPut<DiscoverController>(
      () => DiscoverController(),
    );
  }
}
