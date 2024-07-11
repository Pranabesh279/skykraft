import 'package:get/get.dart';
import 'package:skycraft/app/models/chat/chat_room.dart';

import '../controllers/view_chat_controller.dart';

class ViewChatBinding extends Bindings {
  final ChatRoomMetadata? chatRoomMetadata;

  ViewChatBinding({this.chatRoomMetadata});
  @override
  void dependencies() {
    Get.lazyPut<ViewChatController>(
      () => ViewChatController(
        chatRoomMetadata: chatRoomMetadata,
      ),
    );
  }
}
