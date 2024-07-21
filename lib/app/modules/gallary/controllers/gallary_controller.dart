import 'dart:developer';

import 'package:get/get.dart';
import 'package:skycraft/app/models/posts/post_data_model.dart';
import 'package:skycraft/app/providers/auth_provider.dart';
import 'package:skycraft/app/providers/post_provider.dart';

class GallaryController extends GetxController {
  Rx<List<Posts>> posts = Rx<List<Posts>>([]);
  AuthProvider authProvider = Get.find<AuthProvider>();
  PostProvider postProvider = Get.find<PostProvider>();
  Rx<List<String>?> userGallary = Rx<List<String>?>([]);

  @override
  void onInit() {
    super.onInit();
    userGallary.bindStream(postProvider.getGallery(
      authProvider.userModel.value!.uid!,
    ));
    posts.bindStream(getSavedPosts());
    ever(userGallary, (callback) => getpostsFuture());
  }

  Future<void> getpostsFuture() async {
    List<Posts> post = [];
    post = await postProvider.getPostsByUserFromGalleryFuture(
      authProvider.userModel.value!.uid!,
    );
    log('GallaryController getposts post: $post');
    posts.value = post;
  }

  // }

  Stream<List<Posts>> getSavedPosts() {
    return postProvider.getPostsByUserFromGallery(
      authProvider.userModel.value!.uid!,
    );
  }
}
