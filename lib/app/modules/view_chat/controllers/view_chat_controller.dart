import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:skycraft/app/models/auth/user_model.dart';
import 'package:skycraft/app/models/chat/chat_room.dart';
import 'package:skycraft/app/models/chat/message_data.dart';
import 'package:skycraft/app/providers/auth_provider.dart';

import 'package:skycraft/app/providers/chat_room_provider.dart';

class ViewChatController extends GetxController {
  final GlobalKey<FormState> abcKey = GlobalKey<FormState>();
  RxBool isLoading = RxBool(true);
  ChatRoomProvider chatRoomProvider = Get.find<ChatRoomProvider>();
  Rx<UserModel?> user = Rx<UserModel?>(null);
  final ChatRoomMetadata? chatRoomMetadata;
  ViewChatController({required this.chatRoomMetadata});
  Rx<List<ChatMessage>> messages = Rx<List<ChatMessage>>([]);

  @override
  void onInit() {
    super.onInit();
    user.value = Get.find<AuthProvider>().userModel.value;
    getMessages();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  //   getMessages();
  // }

  void getMessages() {
    messages.bindStream(
        chatRoomProvider.getChatRoom(chatRoomMetadata?.roomId ?? ''));
  }

  Stream<List<ChatMessage>> getMessagesStream() {
    return chatRoomProvider.getChatRoom(chatRoomMetadata?.roomId ?? '');
  }

  UserModel? getOpponentData() {
    String id = getChatOpponentId(
        chatRoomId: chatRoomMetadata?.roomId ?? '',
        currentUserId: Get.find<AuthProvider>().userModel.value!.uid!);
    UserModel user = getChatOpponentData(chatRoomMetadata!, id);
    return user;
  }

  Future<void> sendMessage(String message) async {
    isLoading.value = true;
    //{ delivered, error, seen, sending, sent }
    ChatMessage chatMessage = ChatMessage(
      metadata: {
        'sender': user.value!.toMap(),
        'receiver': getOpponentData()!.toMap(),
        'roomId': chatRoomMetadata?.roomId,
        'messageType': 'text',
        'message': message,
        'status': 'sending',
        'createdAt': DateTime.now().toIso8601String(),
      },
      status: 'sending',
      roomId: chatRoomMetadata?.roomId ?? '',
      author: user.value?.uid ?? "",
      message: message,
      type: 'text',
      showStatus: false,
    );
    await chatRoomProvider.sendMessage(
      chatRoomMetadata?.roomId ?? '',
      message: chatMessage.toMap(),
    );

    isLoading.value = false;
  }
}
