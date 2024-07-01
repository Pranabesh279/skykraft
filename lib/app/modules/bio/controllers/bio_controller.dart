import 'dart:developer';

import 'package:get/get.dart';
import 'package:skycraft/app/models/auth/user_model.dart';
import 'package:skycraft/app/models/chat/chat_room.dart';
import 'package:skycraft/app/providers/auth_provider.dart';
import 'package:skycraft/app/providers/chat_room_provider.dart';

class BioController extends GetxController {
  UserModel? user;
  BioController({this.user});
  ChatRoomProvider chatRoomProvider = Get.find<ChatRoomProvider>();
  RxBool isChatRoomCreated = false.obs;
  RxBool isCreatingChatRoom = false.obs;

  isNotSameUser() {
    return user!.uid != Get.find<AuthProvider>().uid;
  }

  Future<void> createChatRoom() async {
    isCreatingChatRoom.value = true;
    String roomId = getChatRoomId(
      senderId: Get.find<AuthProvider>().userModel.value?.uid ?? "",
      receiverId: user?.uid ?? "",
    );
    ChatRoomMetadata chatRoom = ChatRoomMetadata(
      roomId: roomId,
      sender: Get.find<AuthProvider>().userModel.value,
      receiver: user!,
      createdAt: DateTime.now(),
      members: [
        Get.find<AuthProvider>().userModel.value?.uid ?? "",
        user?.uid ?? ""
      ],
    );
    final chatRoomId = await chatRoomProvider.createChatRoom(chatRoom.toMap());
    log('chatRoomId: $chatRoomId');
    Get.back();
    isCreatingChatRoom.value = false;
  }
}
