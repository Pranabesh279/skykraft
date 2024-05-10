import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:skycraft/app/models/auth/user_model.dart';
import 'package:skycraft/app/routes/app_pages.dart';

class AuthProvider extends GetxService {
  Rx<User?> user = Rx<User?>(null);
  Rx<UserModel?> userModel = Rx<UserModel?>(null);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? get uid => user.value?.uid;

  @override
  void onInit() {
    super.onInit();
    log('AuthProvider started', name: 'Auth');
    user.bindStream(_auth.authStateChanges());
    user.listen((User? u) async {
      if (u == null) {
        userModel.value = null;
        return;
      }
      log('User state changed ${u.uid}', name: 'Auth');
      if (u.uid.isNotEmpty) {
        log('User is signed in', name: 'Auth');
        UserModel? user = await getUserDetails(u.uid);
        userModel.value = user;
        log('User details fetched ${userModel.value}', name: 'Auth');
      } else {
        log('User is signed out', name: 'Auth');
      }
    });
    // userModel.listen((UserModel? u) async {
    //   if (u == null) {
    //     log('UserModel is null', name: 'Auth');
    //     return;
    //   }
    //   log('UserModel state changed ${u.uid}', name: 'Auth');
    //   if (u.walletId == null) {
    //     log('Creating wallet for ${u.uid}', name: 'Auth');
    //     final WalletProvider wallet = Get.find<WalletProvider>();
    //     final id = wallet.createWallet(u.uid!);
    //     await _firestore.collection('users').doc(u.uid).update({
    //       'walletId': id,
    //     });
    //     updateUserData(u.uid!);
    //   }
    // });
  }

  Future<String> signUpUser({
    required String? name,
    required String? email,
    required String? password,
    required String? username,
    required String? phone,
  }) async {
    String result = 'Some error occurred';
    try {
      if (email!.isNotEmpty || name!.isNotEmpty || password!.isNotEmpty) {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: email, password: password!);
        if (user.user == null) return 'Some error occurred';
        Map<String, dynamic> data = {
          'name': name,
          'email': email,
          'username': username,
          'phone': phone,
          'uid': user.user!.uid,
          'isVerified': false,
          'role': null,
          'photoUrl': null,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
          'isDeleted': false,
          'location': null
        };
        // check if user is already registered
        DocumentSnapshot snap =
            await _firestore.collection('users').doc(user.user!.uid).get();
        if (snap.exists) {
          return 'User already exists';
        }
        await _firestore.collection('users').doc(user.user!.uid).set(data);
        result = 'success';
        await updateUserData(_auth.currentUser!.uid);
      }
    } catch (err) {
      result = err.toString();
    }
    return result;
  }

  Future<String> resetPassword({required String email}) async {
    String result = 'Some error occurred';
    try {
      if (email.isNotEmpty) {
        await _auth.sendPasswordResetEmail(email: email);
        result = 'success';
      }
    } catch (err) {
      result = err.toString();
    }
    return result;
  }

  Future<bool> deleteUser() async {
    try {
      String uid = _auth.currentUser!.uid;
      await _firestore.collection('users').doc(uid).delete();

      try {
        await _auth.currentUser!
            .delete()
            .whenComplete(() => Get.offAllNamed(AppPages.INITIAL));
      } catch (e) {
        log('Error deleting user', name: 'Auth');
      }

      return true;
    } catch (err) {
      return false;
    }
  }

  Future<String> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    String result = 'Some error occurred';
    try {
      if (oldPassword.isNotEmpty || newPassword.isNotEmpty) {
        User currentUser = _auth.currentUser!;
        AuthCredential credential = EmailAuthProvider.credential(
            email: currentUser.email!, password: oldPassword);
        await currentUser.reauthenticateWithCredential(credential);
        await currentUser.updatePassword(newPassword);
        result = 'success';
      }
    } catch (err) {
      result = err.toString();
    }
    return result;
  }

  Future<void> signOutUser() async {
    await _auth.signOut();
    Get.offAllNamed(AppPages.INITIAL);
  }

  Future<String> logInUser({
    required String email,
    required String password,
  }) async {
    String result = 'Some error occurred';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        result = 'success';
        await updateUserData(_auth.currentUser!.uid);
      }
    } catch (err) {
      result = err.toString();
    }
    return result;
  }

  Future<UserModel?> getUserDetails(String uid) async {
    DocumentSnapshot snap = await _firestore.collection('users').doc(uid).get();
    if (!snap.exists) return null;
    return UserModel.fromSnap(snap);
  }

  Future<void> updateUserData(String uid) async {
    UserModel? user = await getUserDetails(uid);
    userModel.value = user;
  }

  Future<void> updateUserLocation(String uid, {GeoPoint? geoPoint}) async {
    await _firestore.collection('users').doc(uid).update({
      'location': geoPoint,
    });
    userModel.value = await getUserDetails(uid);
  }

  Stream<UserModel?> getUser(String uid) {
    return _firestore.collection('users').doc(uid).snapshots().map((event) {
      if (!event.exists) return null;
      return UserModel.fromSnap(event);
    });
  }

  Future updateUser(String uid, {required Map<String, dynamic> data}) async {
    await _firestore.collection('users').doc(uid).update(data);
    userModel.value = await getUserDetails(uid);
  }
}
