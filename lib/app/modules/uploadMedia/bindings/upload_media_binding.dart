import 'dart:io';

import 'package:get/get.dart';

import '../controllers/upload_media_controller.dart';

class UploadMediaBinding extends Bindings {
  final File? imageFile;
  UploadMediaBinding({this.imageFile});

  @override
  void dependencies() {
    Get.lazyPut<UploadMediaController>(
      () => UploadMediaController(
        file: imageFile,
      ),
    );
  }
}
