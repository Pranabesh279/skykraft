import 'dart:developer';

import 'package:get/get.dart';
import 'package:skycraft/app/models/auth/user_model.dart';
import 'package:skycraft/app/models/chat/chat_room.dart';
import 'package:skycraft/app/providers/auth_provider.dart';
import 'package:skycraft/app/providers/chat_room_provider.dart';

class ChatRoomController extends GetxController {
  Rx<UserModel?> user = Rx<UserModel?>(null);
  Rx<List<ChatRoomMetadata>> chatRooms = Rx<List<ChatRoomMetadata>>([]);

  @override
  void onInit() {
    super.onInit();
    user.value = Get.find<AuthProvider>().userModel.value;
    getChatRooms();
    ever(user, (callback) => getChatRooms());
  }

  getChatRooms() {
    chatRooms.bindStream(
        Get.find<ChatRoomProvider>().getChatRooms(user.value!.uid!));
  }

  Future getChatRoomsFuture() async {
    chatRooms.value =
        await Get.find<ChatRoomProvider>().getChatRoomsFuture(user.value!.uid!);
    log('Chat rooms fetched ${chatRooms.value.length}',
        name: 'ChatRoomController');
  }
}
