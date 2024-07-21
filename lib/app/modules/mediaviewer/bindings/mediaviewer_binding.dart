import 'package:get/get.dart';
import 'package:skycraft/app/models/posts/post_data_model.dart';

import '../controllers/mediaviewer_controller.dart';

class MediaviewerBinding extends Bindings {
  final Posts? post;

  MediaviewerBinding({this.post});
  @override
  void dependencies() {
    Get.lazyPut<MediaviewerController>(
      () => MediaviewerController(
        post: post,
      ),
    );
  }
}
