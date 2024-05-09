import 'dart:developer';

import 'package:get/get.dart';
import 'package:skycraft/app/models/auth/user_model.dart';
import 'package:skycraft/app/models/posts/post_data_model.dart';
import 'package:skycraft/app/modules/permissions/controllers/permissions_controller.dart';
import 'package:skycraft/app/providers/auth_provider.dart';
import 'package:skycraft/app/providers/post_provider.dart';
import 'package:skycraft/app/providers/wallet_provider.dart';

class ProfileController extends GetxController {
  AuthProvider authProvider = Get.find<AuthProvider>();
  WalletProvider walletProvider = Get.find<WalletProvider>();
  PostProvider postProvider = Get.find<PostProvider>();
  Rx<UserModel?> userData = Rx<UserModel?>(null);
  Rx<List<Posts>> postsList = Rx<List<Posts>>([]);
  Rx<double> coins = 0.0.obs;
  Rx<int> posts = 0.obs;
  PermissionsController permissionsController = Get.isRegistered()
      ? Get.find<PermissionsController>()
      : Get.put<PermissionsController>(PermissionsController());

  @override
  void onInit() {
    super.onInit();
    // PermissionsController().determinePosition();
    getUser();
    getWalletBalance();
    getUserPostsCount();
    ever(posts, (callback) => getUserPosts());
    ever(authProvider.userModel, (callback) => getUser());
  }

  UserModel? get user => userData.value;

  getUser({String? uid}) {
    userData.value = authProvider.userModel.value;
  }

  void getWalletBalance() async {
    if (user?.walletId == null) return;
    coins.bindStream(walletProvider.walletStream(
      user!.uid!,
    ));
  }

  void getUserPostsCount() async {
    if (user?.uid == null) return;
    posts.bindStream(postProvider.getPostsCountStreamByUser(user!.uid!));
  }

  void getUserPosts() async {
    log('Getting user posts');
    final data = await postProvider.getPostsByUser(user!.uid!);
    postsList.value = data!.map((e) => Posts.fromSnap(e)).toList();
    log('User posts fetched ${postsList.value.length}', name: 'Profile');
  }
}
