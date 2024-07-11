import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:skycraft/app/models/chat/chat_room.dart';
import 'package:skycraft/app/models/chat/message_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatRoomProvider extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  createChatRoom(Map<String, dynamic> map) async {
    final String? roomId = map['roomId'];

    try {
      // if exists room id in collection return the collection id
      String? collectionId = await _checkChatRoomExists(roomId);
      if (collectionId != null) {
        return collectionId;
      }
      Map<String, dynamic> data = map;
      data['createdAt'] = FieldValue.serverTimestamp();
      CollectionReference chatRoom = _firestore.collection('chatRooms');
      final chatRoomId = await chatRoom.add(data);
      return chatRoomId.id;
    } catch (e) {
      return null;
    }
  }

  Future<String?> _checkChatRoomExists(String? chatRoomId) async {
    try {
      final QuerySnapshot result = await _firestore
          .collection('chatRooms')
          .where('roomId', isEqualTo: chatRoomId)
          .get();
      if (result.docs.isNotEmpty) {
        return result.docs.first.id;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Stream<List<ChatRoomMetadata>> getChatRooms(String userId) {
    CollectionReference chatRoom = _firestore.collection('chatRooms');
    return chatRoom.where('members', arrayContains: userId).snapshots().map(
        (event) =>
            event.docs.map((e) => ChatRoomMetadata.fromSnap(e)).toList());
  }

  Future<List<ChatRoomMetadata>> getChatRoomsFuture(String userId) async {
    CollectionReference chatRoom = _firestore.collection('chatRooms');
    final QuerySnapshot result =
        await chatRoom.where('members', arrayContains: userId).get();
    return result.docs.map((e) => ChatRoomMetadata.fromSnap(e)).toList();
  }

  Stream<List<ChatMessage>> getChatRoom(String roomId) {
    CollectionReference chatRoom = _firestore.collection('chatRooms');
    return chatRoom
        .doc(roomId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
            (event) => event.docs.map((e) => ChatMessage.fromSnap(e)).toList());
  }

  Future<void> sendMessage(String roomId,
      {required Map<String, dynamic> message}) async {
    CollectionReference chatRoom = _firestore.collection('chatRooms');
    message['createdAt'] = FieldValue.serverTimestamp();
    await chatRoom.doc(roomId).collection('messages').add(message);
  }
}
