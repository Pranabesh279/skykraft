import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skycraft/app/constants/theme_data.dart';
import 'package:skycraft/app/modules/discover/widgets/post_card.dart';
import 'package:skycraft/app/modules/uploadMedia/bindings/upload_media_binding.dart';
import 'package:skycraft/app/modules/uploadMedia/views/upload_media_view.dart';
import 'package:skycraft/app/routes/app_pages.dart';
import 'package:skycraft/app/widgets/profile_image.dart';

import '../controllers/discover_controller.dart';

class DiscoverView extends GetView<DiscoverController> {
  const DiscoverView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Image.asset(
                'assets/skykraft-White.png',
                width: 100,
                color: kPrimary,
              ),
            ],
          ),
        ),
        leadingWidth: 120,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Container(
            color: Colors.grey[300],
            height: 1,
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        // padding: const EdgeInsets.symmetric(
        //   horizontal: 20,
        //   vertical: 20,
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // add potage image/ video
            InkWell(
              onTap: () {
                Get.toNamed(Routes.ADDPOST);
              },
              child: Container(
                height: 60,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  // borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Obx(
                      () => controller.profileController.user?.uid == null
                          ? const SizedBox()
                          : ProfileImage(
                              size: 40,
                              image:
                                  controller.profileController.user?.photoUrl ??
                                      "",
                              userRole:
                                  controller.profileController.user?.role ?? "",
                            ),
                    ),
                    Expanded(
                      child: TextField(
                        onTap: () async {
                          final ImagePicker picker = ImagePicker();
                          XFile? fotage = await picker.pickMedia();
                          if (fotage != null) {
                            Get.to(
                              () => const UploadMediaView(),
                              binding: UploadMediaBinding(
                                imageFile: File(fotage.path),
                              ),
                            );
                          }
                        },
                        readOnly: true,
                        decoration: const InputDecoration(
                          hintText: 'What\'s fotage about?',
                          hintStyle:
                              TextStyle(fontSize: 14, color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 20),
                        ),
                      ),
                    ),
                    const Icon(Icons.add_a_photo_outlined),
                  ],
                ),
              ),
            ),
            // posts
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  return controller.getPosts();
                },
                child: ListView(children: [
                  Obx(
                    () => controller.isLoading.value
                        ? const Center(
                            child: LinearProgressIndicator(),
                          )
                        : Column(
                            children: controller.posts.value
                                .map(
                                  (post) => PostCard(
                                    post: post,
                                  ),
                                )
                                .toList(),
                          ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
