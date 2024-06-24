import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skycraft/app/models/auth/user_model.dart';

class Posts {
  final String? id;
  final String? userId;
  final String? caption;
  final String? url;
  final String? fileType;
  final String? place;
  final int? price;
  final GeoPoint? location;
  final UserModel? user;
  final DateTime? createdAt;
  Posts({
    required this.id,
    required this.userId,
    required this.caption,
    required this.url,
    required this.fileType,
    required this.place,
    required this.location,
    this.price = 0,
    this.user,
    this.createdAt,
  });

  factory Posts.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Posts(
      id: snap.id,
      userId: snapshot['uid'],
      caption: snapshot['caption'],
      url: snapshot['url'],
      fileType: snapshot['fileType'],
      place: snapshot['place'],
      location: snapshot['location'],
      price: int.tryParse(snapshot['price']) ?? 0,
      createdAt: snapshot['createdAt']?.toDate(),
      user: UserModel.fromMap(snapshot['user']),
    );
  }
}
