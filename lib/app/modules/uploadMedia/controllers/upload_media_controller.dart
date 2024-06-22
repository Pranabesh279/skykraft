import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skycraft/app/modules/uploadMedia/widgets/video_player.dart';

class UploadMediaController extends GetxController {
  final File? file;

  UploadMediaController({this.file});
  Rx<File?> imageFile = Rx<File?>(null);

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
}
