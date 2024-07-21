import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:skycraft/app/models/posts/comments_model.dart';
import 'package:skycraft/app/models/posts/post_data_model.dart';
import 'package:skycraft/app/providers/auth_provider.dart';
import 'package:skycraft/app/providers/post_provider.dart';

enum MediaType { image, video }

class MediaviewerController extends GetxController {
  final Posts? post;

  MediaviewerController({required this.post});

  TextEditingController commentController = TextEditingController();
  AuthProvider auth = Get.find<AuthProvider>();
  PostProvider postProvider = Get.find<PostProvider>();
  RxBool isSendingComment = false.obs;
  Rx<List<Comment>> comments = Rx<List<Comment>>([]);

  MediaType get mediaType {
    if (post!.url!.contains('mp4') || post!.url!.contains('mov')) {
      return MediaType.video;
    } else {
      return MediaType.image;
    }
  }

  Future sendComment() async {
    if (commentController.text.isNotEmpty) {
      await postProvider.commentPost(
        post!.id!,
        auth.user.value!.uid,
        commentController.text,
      );
      commentController.clear();
    }
  }

  @override
  void onInit() {
    comments.bindStream(postProvider.getComments(post!.id!));
    super.onInit();
  }
}
