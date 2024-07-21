import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:path/path.dart' as p;
import 'package:skycraft/app/models/posts/comments_model.dart';
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
  Future<List<Posts>?> getPosts() async {
    try {
      final data = await _firestore
          .collection('posts')
          // query by date
          .orderBy('createdAt', descending: true)
          .get();

      return data.docs.map((e) => Posts.fromSnap(e)).toList();
    } catch (err) {
      Get.snackbar('Error', err.toString());
    }
    return null;
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

  Future<void> likePost(String postId, String uid) async {
    try {
      await _firestore.collection('posts').doc(postId).update({
        'likes': FieldValue.arrayUnion([uid])
      });
    } catch (err) {
      Get.snackbar('Error', err.toString());
    }
  }

  Future<void> unlikePost(String postId, String uid) async {
    try {
      await _firestore.collection('posts').doc(postId).update({
        'likes': FieldValue.arrayRemove([uid])
      });
    } catch (err) {
      Get.snackbar('Error', err.toString());
    }
  }

  Stream<bool> isLiked(String postId, String uid) {
    return _firestore
        .collection('posts')
        .doc(postId)
        .snapshots()
        .map((event) => event.data()?['likes']?.contains(uid) ?? false);
  }

  Stream<int> getLikesCount(String postId) {
    return _firestore
        .collection('posts')
        .doc(postId)
        .snapshots()
        .map((event) => event.data()?['likes']?.length ?? 0);
  }

  Future<void> commentPost(String postId, String uid, String comment) async {
    try {
      await _firestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .add({
        'userId': uid,
        'postId': postId,
        'comment': comment,
        'createdAt': FieldValue.serverTimestamp()
      });
    } catch (err) {
      Get.snackbar('Error', err.toString());
    }
  }

  Stream<List<Comment>> getComments(String postId) {
    return _firestore
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .snapshots()
        .map((event) => event.docs.map((e) => Comment.fromSnap(e)).toList());
  }

  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (err) {
      Get.snackbar('Error', err.toString());
    }
  }

  Future<void> savePostToUserGallery(String postId, String uid) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'gallery': FieldValue.arrayUnion([postId])
      });
    } catch (err) {
      Get.snackbar('Error', err.toString());
    }
  }

  Future<void> removePostFromUserGallery(String postId, String uid) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'gallery': FieldValue.arrayRemove([postId])
      });
    } catch (err) {
      Get.snackbar('Error', err.toString());
    }
  }

  Stream<bool> isPostInUserGallery(String postId, String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((event) => event.data()?['gallery']?.contains(postId) ?? false);
  }

  Stream<List<String>> getGallery(String uid) {
    return _firestore.collection('users').doc(uid).snapshots().map((event) =>
        (event.data()?['gallery'] as List<dynamic>? ?? [])
            .map((e) => e as String)
            .toList());
  }

  Stream<List<Posts>> getPostsByUserFromGallery(String uid) {
    List<String> galleryPostIds = [];
    _firestore.collection('users').doc(uid).get().then((value) {
      galleryPostIds = (value.data()?['gallery'] as List<dynamic>? ?? [])
          .map((e) => e as String)
          .toList();
    });
    log('GallaryController glarry: $galleryPostIds');
    final res = _firestore.collection('posts').snapshots().map((event) => event
        .docs
        .where((e) => galleryPostIds.contains(e.id))
        .map((e) => Posts.fromSnap(e))
        .toList());
    log('GallaryController: $res');
    return res;
  }

  Future<List<Posts>> getPostsByUserFromGalleryFuture(String uid) async {
    try {
      List<String> galleryPostIds = [];
      _firestore.collection('users').doc(uid).get().then((value) {
        galleryPostIds = (value.data()?['gallery'] as List<dynamic>? ?? [])
            .map((e) => e as String)
            .toList();
      });
      final res = _firestore.collection('posts').get();
      log('GallaryController: $res');
      return res.then((value) => value.docs
          .where((e) => galleryPostIds.contains(e.id))
          .map((e) => Posts.fromSnap(e))
          .toList());
    } catch (err) {
      Get.snackbar('Error', err.toString());
    }
    return [];
  }

  Stream<List<Posts>> getPostsByUserFromLikes(String uid) {
    return _firestore
        .collection('posts')
        .where('likes', arrayContains: uid)
        .snapshots()
        .map((event) => event.docs.map((e) => Posts.fromSnap(e)).toList());
  }

  Stream<List<Posts>> getPostsByUserFromComments(String uid) {
    return _firestore
        .collection('posts')
        .where('comments', arrayContains: uid)
        .snapshots()
        .map((event) => event.docs.map((e) => Posts.fromSnap(e)).toList());
  }

  Future<List<Posts>> getPostsByUserFromCommentsFuture(String uid) async {
    try {
      final data = await _firestore
          .collection('posts')
          .where('uid', isEqualTo: uid)
          .get();
      return data.docs.map((e) => Posts.fromSnap(e)).toList();
    } catch (err) {
      Get.snackbar('Error', err.toString());
    }
    return [];
  }

  Stream<List<Posts>> getPostsByUserId(String uid) {
    return _firestore
        .collection('posts')
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((event) => event.docs.map((e) => Posts.fromSnap(e)).toList());
  }
}
