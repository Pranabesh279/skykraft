import 'package:get/get.dart';

import '../controllers/mediaviewer_controller.dart';

class MediaviewerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MediaviewerController>(
      () => MediaviewerController(),
    );
  }
}
