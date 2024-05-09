import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:skycraft/app/constants/constants.dart';
import 'package:skycraft/app/models/auth/user_model.dart';

class UserProvider extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<UserModel> users = <UserModel>[].obs;

  // get all users
  Future getUsers() async {
    try {
      final data = await _firestore
          .collection('users')
          .where('role', isEqualTo: UserRole.dronePilot)
          .get();
      users.value = data.docs.map((e) => UserModel.fromMap(e.data())).toList();
    } catch (err) {
      Get.snackbar('Error', err.toString());
    }
  }

  Stream<List<UserModel>> droneUsers() {
    return _firestore
        .collection('users')
        .where('role', isEqualTo: UserRole.dronePilot)
        .snapshots()
        .map((event) => event.docs.map((e) => UserModel.fromSnap(e)).toList());
  }

  Stream<UserModel?> userStream(String uid) {
    if (uid.isEmpty) {
      return Stream.value(null);
    }
    return _firestore.collection('users').doc(uid).snapshots().map((event) {
      return UserModel.fromSnap(event);
    });
  }
}
