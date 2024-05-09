import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:skycraft/app/constants/constants.dart';
import 'package:skycraft/app/constants/theme_data.dart';

class ProfileImage extends StatelessWidget {
  final String name;
  final String? userRole;
  final double? size;

  const ProfileImage(
      {super.key, required this.name, required this.userRole, this.size});

  @override
  Widget build(BuildContext context) {
    return AdvancedAvatar(
      size: size ?? 60,
      margin: const EdgeInsets.all(1),
      animated: true,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: kTextColor,
        border: Border.all(
          color: kPrimaryColor,
          width: 2,
        ),
      ),
      // statusColor: Colors.green,
      children: [
        if (userRole != null && userRole == UserRole.dronePilot) ...[
          Container(
            height: 18,
            width: 18,
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Image.asset(
              'assets/icons/drone.png',
              height: 14,
              width: 14,
            ),
          ),
        ]
      ],
      child: RandomAvatar(
        (name),
      ),
    );
  }
}
