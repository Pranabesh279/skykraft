import 'package:get/get.dart';

import '../controllers/gallary_controller.dart';

class GallaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GallaryController>(
      () => GallaryController(),
    );
  }
}
