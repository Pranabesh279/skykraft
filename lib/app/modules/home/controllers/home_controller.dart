import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:skycraft/app/constants/theme_data.dart';
import 'package:skycraft/app/models/auth/user_model.dart';
import 'package:skycraft/app/models/posts/post_data_model.dart';
import 'package:skycraft/app/modules/bio/bindings/bio_binding.dart';

import 'package:skycraft/app/modules/bio/views/bio_view.dart';

import 'package:skycraft/app/modules/permissions/controllers/permissions_controller.dart';

import 'package:skycraft/app/providers/post_provider.dart';
import 'package:skycraft/app/providers/users_provider.dart';
import 'package:skycraft/app/utils/utils.dart';
import 'package:skycraft/app/widgets/profile_image.dart';

class HomeController extends GetxController {
  Completer<GoogleMapController> mapController = Completer();
  UserProvider userProvider = Get.find<UserProvider>();
  PostProvider postProvider = Get.find<PostProvider>();
  Rx<CameraPosition> kInitialPosition = const CameraPosition(
    target: LatLng(24.115294841764197, 78.64444602280855),
    zoom: 4.479615688323975,
  ).obs;
  RxInt selectedIndex = 0.obs;
  Rx<List<Marker>> userMarkers = Rx<List<Marker>>([]);
  Rx<List<Marker>> postMarkers = Rx<List<Marker>>([]);
  RxList<UserModel> droneUsers = <UserModel>[].obs;
  RxList<Posts> dronePosts = <Posts>[].obs;
  Rx<List<Posts>> postsList = Rx<List<Posts>>([]);
  PermissionsController permissionsController = Get.isRegistered()
      ? Get.find<PermissionsController>()
      : Get.put<PermissionsController>(PermissionsController());
  @override
  void onInit() {
    super.onInit();
    checkPer();
    getUserMarkers();
    getPost();
    ever(droneUsers, (callback) async => updateMarkers());
    ever(dronePosts, (callback) async => getPostMarkers());
  }

  void checkPer() async {
    bool locationPer = await PermissionsController().checkPermission();
    log('locationPer: $locationPer');
  }

  void getUserMarkers() {
    droneUsers.bindStream(userProvider.droneUsers());
  }

  void getPost() {
    log('Getting posts home');
    dronePosts.bindStream(postProvider.dronePosts());
  }

  Future updateMarkers() async {
    List<Marker> m = [];
    for (var user in droneUsers) {
      log('user: ${user.name}');
      Future<BitmapDescriptor> getCustomIcon() async {
        return SizedBox(
          height: 60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ProfileImage(
                image: user.photoUrl!,
                userRole: user.role,
                size: 30,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(user.name!,
                    style: const TextStyle(
                      fontSize: 10,
                      color: kBlackColor,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ],
          ),
        ).toBitmapDescriptor();
      }

      if (user.location == null) continue;
      m.add(
        Marker(
          markerId: MarkerId(user.uid!),
          position: LatLng(user.location!.latitude, user.location!.longitude),
          onTap: () {
            Get.to(
              () => const BioView(),
              binding: BioBinding(user: user),
              fullscreenDialog: false,
              transition: Transition.downToUp,
            );
          },
          icon: await getCustomIcon(),
        ),
      );
    }
    userMarkers.value = m;
  }

  getPostMarkers() async {
    List<Marker> m = [];
    // for (var post in dronePosts) {
    //   Future<BitmapDescriptor> getCustomIcon() async {
    //     final tumb = await VideoThumbnail.thumbnailFile(
    //       video: post.url,
    //       imageFormat: ImageFormat.JPEG,
    //       maxWidth: 128,
    //       quality: 60,
    //     );
    //     return SizedBox(
    //       height: 100,
    //       width: 100,
    //       child: Material(
    //           elevation: 0,
    //           color: Colors.transparent,
    //           borderRadius: BorderRadius.circular(5),
    //           child: PostCards(post: post, tumb: tumb)),
    //     ).toBitmapDescriptor();
    //   }

    //   m.add(
    //     Marker(
    //       markerId: MarkerId(post.title),
    //       position: LatLng(post.location.latitude, post.location.longitude),
    //       icon: await getCustomIcon(),
    //     ),
    //   );
    // }
    postMarkers.value = m;
    log('posts home: ${postMarkers.value.length}');
  }
}
