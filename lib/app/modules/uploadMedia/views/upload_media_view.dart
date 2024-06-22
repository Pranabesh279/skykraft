import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/upload_media_controller.dart';

class UploadMediaView extends GetView<UploadMediaController> {
  const UploadMediaView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CupertinoNavigationBar(
        middle: Text('Create Post'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: controller.mediabyTypeVideoOrImage,
                ),
                // set price of this fotage
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                    maxLength: 100,
                    decoration: const InputDecoration(
                      prefixIcon:
                          Icon(Icons.description_outlined, color: Colors.grey),
                      hintText: 'Write a caption for this footage ...',
                      hintStyle: TextStyle(
                          color: Colors.grey, fontSize: 14, height: 1.5),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Text('Set price of this footage',
                      style: TextStyle(
                        // color: kPrimaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 4.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Ex: 1000',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                      border: InputBorder.none,
                      prefixIcon: Container(
                          alignment: Alignment.center,
                          width: 50,
                          child: Image.asset(
                            'assets/icons/coins.png',
                          )),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        controller.onChangedImageFile();
                      },
                      icon: const Icon(
                        Icons.image_outlined,
                        color: Colors.grey,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.onChangedVideoFile();
                      },
                      icon: const Icon(
                        Icons.videocam_outlined,
                        color: Colors.grey,
                      ),
                    ),
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: const Icon(
                    //     Icons.location_on_outlined,
                    //     color: Colors.grey,
                    //   ),
                    // ),
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: const Icon(
                    //     Icons.tag_faces_outlined,
                    //     color: Colors.grey,
                    //   ),
                    // ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.send_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
