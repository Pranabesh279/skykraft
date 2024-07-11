import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String author;
  final DateTime? createdAt;
  final String? id;
  final String message;
  final Map<String, dynamic>? metadata;
  final String? remoteId;
  final ChatMessage? repliedMessage;
  final String roomId;
  final bool? showStatus;
  final String status;
  final String type;
  final DateTime? updatedAt;

  ChatMessage({
    required this.author,
    this.createdAt,
    this.id,
    required this.message,
    this.metadata,
    this.remoteId,
    this.repliedMessage,
    required this.roomId,
    this.showStatus,
    required this.status,
    required this.type,
    this.updatedAt,
  });

  factory ChatMessage.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return ChatMessage(
      message: snapshot['message'] ?? "Deleted message",
      author: snapshot['author'],
      createdAt: snapshot['createdAt']?.toDate(),
      id: snapshot['id'],
      metadata: snapshot['metadata'],
      remoteId: snapshot['remoteId'],
      repliedMessage: snapshot['repliedMessage'],
      roomId: snapshot['roomId'],
      showStatus: snapshot['showStatus'],
      status: snapshot['status'],
      type: snapshot['type'],
      updatedAt: snapshot['updatedAt']?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'author': author,
      'createdAt': createdAt,
      'id': id,
      'metadata': metadata,
      'remoteId': remoteId,
      'repliedMessage': repliedMessage,
      'roomId': roomId,
      'showStatus': showStatus,
      'status': status,
      'type': type,
      'updatedAt': updatedAt,
      'message': message,
    };
  }
}
