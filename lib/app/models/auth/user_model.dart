import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? name;
  final String? email;
  final String? username;
  final String? phone;
  final String? uid;
  final bool? isVerified;
  final String? role;
  final String? photoUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? isDeleted;
  final GeoPoint? location;
  final String? walletId;
  final int? level;
  UserModel({
    this.name,
    this.email,
    this.username,
    this.phone,
    this.uid,
    this.isVerified,
    this.role,
    this.photoUrl,
    this.createdAt,
    this.updatedAt,
    this.isDeleted,
    this.location,
    this.walletId,
    this.level,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      name: data['name'],
      email: data['email'],
      username: data['username'],
      phone: data['phone'],
      uid: data['uid'],
      isVerified: data['isVerified'],
      role: data['role'],
      photoUrl: data['photoUrl'],
      createdAt: data['createdAt']?.toDate(),
      updatedAt: data['updatedAt']?.toDate(),
      isDeleted: data['isDeleted'],
      location: data['location'],
      walletId: data['walletId'],
      level: data['level'],
    );
  }

  factory UserModel.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      name: snapshot['name'],
      email: snapshot['email'],
      username: snapshot['username'],
      phone: snapshot['phone'],
      uid: snapshot['uid'],
      isVerified: snapshot['isVerified'],
      role: snapshot['role'],
      photoUrl: snapshot['photoUrl'],
      isDeleted: snapshot['isDeleted'],
      location: snapshot['location'],
      walletId: snapshot['walletId'],
      level: snapshot['level'],
    );
  }

  // toMap() {
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'username': username,
      'phone': phone,
      'uid': uid,
      'isVerified': isVerified,
      'role': role,
      'photoUrl': photoUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isDeleted': isDeleted,
      'location': location,
      'walletId': walletId,
      'level': level,
    };
  }
}
