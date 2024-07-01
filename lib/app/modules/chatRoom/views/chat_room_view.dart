import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skycraft/app/constants/theme_data.dart';
import 'package:skycraft/app/models/auth/user_model.dart';
import 'package:skycraft/app/models/chat/chat_room.dart';
import 'package:skycraft/app/widgets/profile_image.dart';

import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

import '../controllers/chat_room_controller.dart';

class ChatRoomView extends GetView<ChatRoomController> {
  const ChatRoomView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CupertinoNavigationBar(
        middle: Text("Connect's"),
        backgroundColor: kBackgroundColor,
      ),
      body: Obx(() => RefreshIndicator(
            onRefresh: () {
              return controller.getChatRoomsFuture();
            },
            child: Container(
              decoration: const BoxDecoration(
                color: kBackgroundColor,
              ),
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  color: kPrimary,
                  thickness: 0.15,
                ),
                itemCount: controller.chatRooms.value.length,
                itemBuilder: (context, index) {
                  String id = getChatOpponentId(
                      chatRoomId:
                          controller.chatRooms.value[index].roomId ?? '',
                      currentUserId: controller.user.value!.uid!);
                  UserModel user = getChatOpponentData(
                      controller.chatRooms.value[index], id);
                  return ListTile(
                    leading: ProfileImage(
                      image: user.photoUrl ?? '',
                      size: 50,
                      userRole: user.role ?? '',
                    ),
                    title: Text(
                      user.name ?? '',
                      style: const TextStyle(
                          fontSize: 16,
                          color: kPrimary,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      controller.chatRooms.value[index].lastMessage ??
                          DateFormat('dd MMM, hh:mm a').format(
                              controller.chatRooms.value[index].createdAt!),
                      style: TextStyle(
                        fontSize: 14,
                        color: kPrimary.withOpacity(0.5),
                      ),
                    ),
                  );
                },
              ),
            ),
          )),
    );
  }
}
