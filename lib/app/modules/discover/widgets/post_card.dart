import 'dart:async';
import 'dart:developer';

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:get/get.dart';
import 'package:skycraft/app/constants/theme_data.dart';
import 'package:skycraft/app/models/posts/post_data_model.dart';
import 'package:skycraft/app/modules/mediaviewer/bindings/mediaviewer_binding.dart';
import 'package:skycraft/app/modules/mediaviewer/views/mediaviewer_view.dart';
import 'package:skycraft/app/modules/uploadMedia/widgets/video_player_network.dart';
import 'package:skycraft/app/providers/auth_provider.dart';
import 'package:skycraft/app/providers/post_provider.dart';
import 'package:skycraft/app/widgets/profile_image.dart';

class PostCard extends StatelessWidget {
  final Posts post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 2,
      ),
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              ProfileImage(
                size: 40,
                image: post.user?.photoUrl ?? "",
                userRole: post.user?.role ?? "",
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.user?.name ?? "",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    post.createdAt.toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            post.caption ?? "",
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Container(
              color: Colors.black,
              constraints: const BoxConstraints(
                maxHeight: 300,
                maxWidth: double.infinity,
              ),
              child: buildImage(post.url ?? "", post.fileType ?? "")),
          const SizedBox(height: 10),
          Row(
            children: [
              StreamBuilder(
                  stream: Get.find<PostProvider>().isLiked(
                      post.id!, Get.find<AuthProvider>().userModel.value!.uid!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox();
                    }
                    return IconButton(
                      onPressed: () {
                        snapshot.data == true
                            ? Get.find<PostProvider>().unlikePost(
                                post.id!,
                                Get.find<AuthProvider>().userModel.value!.uid!,
                              )
                            : Get.find<PostProvider>().likePost(
                                post.id!,
                                Get.find<AuthProvider>().userModel.value!.uid!,
                              );
                      },
                      icon: snapshot.data == true
                          ? const Icon(
                              Icons.thumb_up,
                              color: kPrimary,
                            )
                          : const Icon(
                              Icons.thumb_up_off_alt_outlined,
                              color: Colors.grey,
                            ),
                    );
                  }),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: StreamBuilder(
                    stream: Get.find<PostProvider>().getLikesCount(post.id!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox();
                      }
                      return Text(
                        '${snapshot.data}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      );
                    }),
              ),

              // comment button
              IconButton(
                onPressed: () {
                  Get.to(const MediaviewerView(),
                      binding: MediaviewerBinding(
                        post: post,
                      ));
                },
                icon: const Icon(
                  Icons.comment,
                  color: Colors.grey,
                ),
              ),
              const Spacer(),
              // save post button to gallery
              StreamBuilder(
                  builder: (context, snapshot) {
                    return IconButton(
                        onPressed: () {
                          snapshot.data == true
                              ? Get.find<PostProvider>()
                                  .removePostFromUserGallery(
                                  post.id!,
                                  Get.find<AuthProvider>()
                                      .userModel
                                      .value!
                                      .uid!,
                                )
                              : Get.find<PostProvider>().savePostToUserGallery(
                                  post.id!,
                                  Get.find<AuthProvider>()
                                      .userModel
                                      .value!
                                      .uid!,
                                );
                        },
                        icon: snapshot.data == true
                            ? const Icon(
                                Icons.bookmark,
                                color: kPrimary,
                              )
                            : const Icon(
                                Icons.bookmark_border,
                                color: Colors.grey,
                              ));
                  },
                  stream: Get.find<PostProvider>().isPostInUserGallery(
                      post.id!, Get.find<AuthProvider>().userModel.value!.uid!))
            ],
          ),
        ],
      ),
    );
  }

  Widget buildImage(String url, String fileType) {
    final List<String> imageExtensions = [
      'jpg',
      'jpeg',
      'png',
    ];
    final List<String> videoExtensions = ['mp4', 'mov', 'avi', 'flv'];
    if (imageExtensions.contains(fileType)) {
      Image image = Image.network(url);
      Completer<ui.Image> completer = Completer<ui.Image>();
      image.image.resolve(const ImageConfiguration()).addListener(
        ImageStreamListener(
          (ImageInfo info, bool _) {
            completer.complete(info.image);
          },
        ),
      );
      return FutureBuilder<ui.Image>(
        future: completer.future,
        builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            log('height: ${snapshot.data!.height} width: ${snapshot.data!.width}');
            return Container(
              constraints: BoxConstraints(
                maxHeight: snapshot.data!.height.toDouble(),
                maxWidth: double.infinity,
              ),
              child: SizedBox(
                height: snapshot.data!.height.toDouble(),
                width: snapshot.data!.width.toDouble(),
                child: Image.network(url),
              ),
            );
          } else {
            return Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey,
            );
          }
        },
      );
    } else if (videoExtensions.contains(fileType)) {
      return VideoPlayerNetwork(
        videoFile: url,
      );
    } else {
      return const SizedBox();
    }
  }

  List<Reaction<String>> get reactions => <Reaction<String>>[
        const Reaction<String>(
          value: 'like',
          icon: Icon(
            Icons.thumb_up_off_alt_outlined,
            size: 18,
          ),
        ),
      ];
}
