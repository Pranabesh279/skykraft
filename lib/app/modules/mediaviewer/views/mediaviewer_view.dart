import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:skycraft/app/widgets/profile_image.dart';

import '../controllers/mediaviewer_controller.dart';

class MediaviewerView extends GetView<MediaviewerController> {
  const MediaviewerView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
                ProfileImage(
                  size: 40,
                  image: controller.post?.user?.photoUrl ?? "",
                  userRole: controller.post?.user?.role ?? "",
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.post?.user?.name ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      (controller.post?.user?.role ?? "").capitalizeFirst!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              color: Colors.black,
              width: double.infinity,
              height: double.infinity,
              child: controller.mediaType == MediaType.image
                  ? Image.network(controller.post?.url ?? "")
                  : controller.mediaType == MediaType.video
                      ? Image.network(controller.post?.url ?? "")
                      : const SizedBox.shrink(),
            ),
            // comment section in bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                color: Colors.black.withOpacity(0.5),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.commentController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: "Add a comment",
                          hintStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Obx(
                      () => controller.isSendingComment.value
                          ? const CircularProgressIndicator()
                          : IconButton(
                              onPressed: () {
                                controller.sendComment();
                              },
                              icon: const Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
            // show comments
            Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 200,
                // color: Colors.black.withOpacity(0.5),
                child: Obx(() => ListView.builder(
                      reverse: true,
                      itemCount: controller.comments.value.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          subtitle: Text(
                            controller.comments.value[index].content ?? "",
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    )),
              ),
            ),
          ],
        ));
  }
}
