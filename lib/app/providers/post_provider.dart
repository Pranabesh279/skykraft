import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:path/path.dart' as p;
import 'package:skycraft/app/models/posts/post_data_model.dart';
import 'package:skycraft/app/providers/wallet_provider.dart';
import 'package:skycraft/app/service/storage_service.dart';

class PostProvider extends GetxService {
  WalletProvider walletProvider = Get.find();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // create a new post
  Future<String?> createPost(
      {required Map<String, dynamic> data, required File file}) async {
    try {
      final url = await StorageBucketService.uploadAndGetDownloadUrl(file,
          path: '${data['uid']}/posts/${p.basename(file.path)}');
      data['url'] = url;
      data['createdAt'] = FieldValue.serverTimestamp();
      data['fileType'] = p.extension(file.path).replaceAll('.', '');
      final doc = await _firestore.collection('posts').add(data);
      return doc.id;
    } catch (err) {
      Get.snackbar('Error', err.toString());
      return null;
    }
  }

  Future<bool> buyPost(String postId, String uid) async {
    return Future.delayed(const Duration(seconds: 2), () => false);
  }

  // get all posts by a user
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?> getPostsByUser(
      String uid) async {
    try {
      final data = await _firestore
          .collection('posts')
          .where('buyers', arrayContains: uid)
          .get();
      return data.docs;
    } catch (err) {
      Get.snackbar('Error', err.toString());
      return null;
    }
  }

  // get all posts
  Future getPosts() async {
    try {
      final data = await _firestore.collection('posts').get();
      return data.docs;
    } catch (err) {
      Get.snackbar('Error', err.toString());
    }
  }

  Stream<int> getPostsCountStreamByUser(String uid) {
    return _firestore
        .collection('posts')
        .where('buyers', arrayContains: uid)
        .snapshots()
        .map((event) => event.docs.length);
  }

  Stream<List<Posts>> dronePosts() {
    return _firestore
        .collection('posts')
        // .where('role', isEqualTo: UserRole.dronePilot)
        .snapshots()
        .map((event) => event.docs.map((e) => Posts.fromSnap(e)).toList());
  }
}
