import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String? id;
  final String? postId;
  final String? userId;
  final String? content;
  final DateTime? createdAt;

  Comment({
    this.id,
    this.postId,
    this.userId,
    this.content,
    this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      postId: json['postId'],
      userId: json['userId'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  // from Snapshot
  factory Comment.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Comment(
      id: snap.id,
      userId: snapshot['userId'],
      content: snapshot['comment'],
      createdAt: snapshot['createdAt']?.toDate(),
    );
  }
}
