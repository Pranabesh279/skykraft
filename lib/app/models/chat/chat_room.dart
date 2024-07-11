import 'package:skycraft/app/models/auth/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomMetadata {
  final String? roomId;
  final String? id;
  final String? name;
  final String? description;
  final String? imageUrl;
  final String? lastMessage;
  final String? lastMessageTime;
  final String? lastMessageSender;
  final int? unreadCount;
  final bool? isPinned;
  final bool? isMuted;
  final bool? isArchived;
  final List<String>? members;
  final UserModel? sender;
  final UserModel? receiver;
  final DateTime? createdAt;

  ChatRoomMetadata({
    required this.roomId,
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.lastMessage,
    this.lastMessageTime,
    this.lastMessageSender,
    this.unreadCount,
    this.isPinned,
    this.isMuted,
    this.isArchived,
    required this.sender,
    required this.receiver,
    required this.members,
    this.createdAt,
  });

  factory ChatRoomMetadata.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return ChatRoomMetadata(
      id: snap.id,
      roomId: snapshot['roomId'],
      name: snapshot['name'],
      description: snapshot['description'],
      imageUrl: snapshot['imageUrl'],
      lastMessage: snapshot['lastMessage'],
      lastMessageTime: snapshot['lastMessageTime'],
      lastMessageSender: snapshot['lastMessageSender'],
      unreadCount: snapshot['unreadCount'],
      isPinned: snapshot['isPinned'],
      isMuted: snapshot['isMuted'],
      isArchived: snapshot['isArchived'],
      createdAt: snapshot['createdAt']?.toDate(),
      members: List<String>.from(snapshot['members']),
      sender: UserModel.fromMap(snapshot['sender']),
      receiver: UserModel.fromMap(snapshot['receiver']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'roomId': roomId,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
      'lastMessageSender': lastMessageSender,
      'unreadCount': unreadCount,
      'isPinned': isPinned,
      'isMuted': isMuted,
      'isArchived': isArchived,
      'sender': sender!.toMap(),
      'receiver': receiver!.toMap(),
      'members': members,
      'createdAt': createdAt,
    };
  }
}

String getChatRoomId({required String senderId, required String receiverId}) {
  if (senderId.compareTo(receiverId) > 0) {
    return '$receiverId-$senderId';
  } else {
    return '$senderId-$receiverId';
  }
}

String getChatOpponentId(
    {required String chatRoomId, required String currentUserId}) {
  List<String> ids = chatRoomId.split('-');
  if (ids[0] == currentUserId) {
    return ids[1];
  } else {
    return ids[0];
  }
}

UserModel getChatOpponentData(ChatRoomMetadata chatRoom, String id) {
  if (chatRoom.sender!.uid != id) {
    return chatRoom.receiver!;
  } else {
    return chatRoom.sender!;
  }
}
