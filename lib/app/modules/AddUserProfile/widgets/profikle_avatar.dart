import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skycraft/app/constants/theme_data.dart';

class ProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  final File? imageFile;
  final bool? isError;
  final VoidCallback? onTap;
  const ProfileAvatar(
      {super.key, this.imageUrl, this.onTap, this.imageFile, this.isError});

  @override
  Widget build(BuildContext context) {
    log('ProfileAvatar build $imageUrl $imageFile');
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isError == true ? Colors.red : kPrimary.withOpacity(0.1),
            width: 0.1,
          ),
        ),
        child: Stack(
          children: [
            CircleAvatar(
              backgroundColor: kSeconderyBackgroundColor,
              radius: 40,
              child: ClipOval(
                child: imageFile != null
                    ? Image.file(
                        imageFile!,
                        fit: BoxFit.cover,
                        width: 80,
                        height: 80,
                      )
                    : imageUrl != null
                        ? Image.network(
                            imageUrl!,
                            fit: BoxFit.cover,
                            width: 80,
                            height: 80,
                          )
                        : SvgPicture.asset(
                            'assets/icons/ei_user.svg',
                            width: 40,
                            height: 40,
                          ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: kPrimary,
                ),
                child: const Center(
                  child: Icon(
                    Icons.camera_alt,
                    color: kWhiteColor,
                    size: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
