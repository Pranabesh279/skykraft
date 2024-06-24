import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertagger/fluttertagger.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skycraft/app/helpers/snackbar.dart';
import 'package:skycraft/app/modules/uploadMedia/widgets/video_player.dart';
import 'package:skycraft/app/providers/auth_provider.dart';
import 'package:skycraft/app/providers/post_provider.dart';

class UploadMediaController extends GetxController {
  RxBool isLoading = false.obs;
  final File? file;
  final fromKey = GlobalKey<FormState>();
  TextEditingController captionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  FlutterTaggerController flutterTaggerController = FlutterTaggerController();
  UploadMediaController({this.file});
  Rx<File?> imageFile = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    imageFile.value = file;
  }

  Widget get mediabyTypeVideoOrImage {
    // 16:9 aspect ratio
    if (imageFile.value!.path.contains('.mp4')) {
      return VideoPlayerAssets(
        videoFile: imageFile.value!,
      );
    } else {
      return SizedBox(
        height: 200,
        width: 200,
        child: Image.file(
          imageFile.value!,
          fit: BoxFit.cover,
        ),
      );
    }
  }

  void onChangedImageFile() {
    final ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((value) {
      imageFile.value = File(value!.path);
    });
  }

  void onChangedVideoFile() {
    final ImagePicker picker = ImagePicker();
    picker.pickVideo(source: ImageSource.gallery).then((value) {
      imageFile.value = File(value!.path);
    });
  }

  void uploadMedia() async {
    if (fromKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        final res = await Get.find<PostProvider>().createPost(
          data: {
            'caption': flutterTaggerController.formattedText,
            'price': priceController.text,
            'userId': Get.find<AuthProvider>().userModel.value!.uid,
            'user': Get.find<AuthProvider>().userModel.value!.toMap(),
          },
          file: imageFile.value!,
        );
        log('Post created successfully $res');
        if (res != null && res.isNotEmpty) {
          Get.back();
        }
      } catch (e) {
        snackbar(
          title: 'Error',
          message: 'Something went wrong',
          type: SnackbarType.error,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }
}
