import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
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
        child: CircleAvatar(
          backgroundColor: kBackgroundColor,
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
                    : const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.person_outlined,
                          size: 40,
                          color: kPrimary,
                        ),
                      ),
          ),
        ),
      ),
    );
  }
}
