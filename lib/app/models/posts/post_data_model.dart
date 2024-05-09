import 'package:cloud_firestore/cloud_firestore.dart';

class Posts {
  final String id;
  final String userId;
  final String title;
  final String url;
  final String fileType;
  final String place;
  final int price;
  final GeoPoint location;
  Posts({
    required this.id,
    required this.userId,
    required this.title,
    required this.url,
    required this.fileType,
    required this.place,
    required this.location,
    this.price = 0,
  });

  factory Posts.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Posts(
      id: snap.id,
      userId: snapshot['uid'],
      title: snapshot['details'],
      url: snapshot['url'],
      fileType: snapshot['fileType'],
      place: snapshot['place'],
      location: snapshot['location'],
      price: snapshot['price'],
    );
  }
}
