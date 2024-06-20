import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerPopup extends StatelessWidget {
  const ImagePickerPopup(
      {super.key, required this.onTapCamera, required this.onTapGallery});
  final Function(File? file) onTapCamera;
  final Function(File? file) onTapGallery;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                enableFeedback: true,
                onTap: () async {
                  final pickedImage = await ImagePicker().pickImage(
                    source: ImageSource.camera,
                    preferredCameraDevice: CameraDevice.front,
                    imageQuality: 100,
                    maxWidth: 1000,
                  );

                  final file = File(pickedImage!.path);
                  onTapCamera(file);
                },
                child: Column(
                  children: [
                    Icon(
                        size: 36,
                        color: Colors.grey[700],
                        Icons.camera_alt_rounded),
                    const Text("Camera")
                  ],
                ),
              ),
              InkWell(
                enableFeedback: true,
                onTap: () {
                  ImagePicker()
                      .pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 100,
                    maxWidth: 1000,
                  )
                      .then((pickedImage) {
                    final file = File(pickedImage!.path);
                    onTapGallery(file);
                  });
                },
                child: Column(
                  children: [
                    Icon(
                        size: 36, color: Colors.grey[700], Icons.image_rounded),
                    const Text("Gallery")
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
