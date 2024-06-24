import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:skycraft/app/models/posts/post_data_model.dart';
import 'package:skycraft/app/modules/profile/controllers/profile_controller.dart';
import 'package:skycraft/app/providers/post_provider.dart';

class DiscoverController extends GetxController {
  RxBool isLoading = false.obs;
  PostProvider postController = Get.find<PostProvider>();
  ProfileController profileController = Get.find<ProfileController>();
  Rx<List<Posts>> posts = Rx<List<Posts>>([]);

  @override
  void onInit() {
    super.onInit();
    getPosts();
  }

  Future getPosts() async {
    isLoading.value = true;
    try {
      final posts = await postController.getPosts();
      log(posts.toString(), name: 'DiscoverController');
      this.posts.value = posts ?? [];
      isLoading.value = false;
    } catch (e) {
      log(e.toString(), name: 'DiscoverController');
    } finally {
      isLoading.value = false;
    }
  }
}
