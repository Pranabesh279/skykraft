import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertagger/fluttertagger.dart';

import 'package:get/get.dart';
import 'package:skycraft/app/constants/theme_data.dart';

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
            Form(
              key: controller.fromKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: 200,
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      child: controller.mediabyTypeVideoOrImage,
                    ),
                  ),
                  // set price of this fotage
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: FlutterTagger(
                      controller: controller.flutterTaggerController,
                      onSearch: (query, triggerCharacter) {
                        log('query: $query, triggerCharacter: $triggerCharacter');
                        //perform search
                      },
                      triggerCharacterAndStyles: const {
                        "@": TextStyle(
                            color: kPinkColor, fontWeight: FontWeight.bold),
                        "#": TextStyle(
                            color: kPrimary, fontWeight: FontWeight.bold),
                      },
                      overlay: Container(),
                      builder: (context, containerKey) {
                        return Container(
                          key: containerKey,
                          child: TextFormField(
                            controller: controller.flutterTaggerController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter caption';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              log(controller.flutterTaggerController.text,
                                  name: 'text');
                              log(
                                  controller
                                      .flutterTaggerController.formattedText,
                                  name: 'formattedText');
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(top: 12),
                              prefixIcon: Icon(Icons.description_outlined,
                                  color: Colors.grey),
                              hintText: 'Write a caption for this footage ...',
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  height: 1.5),
                              border: InputBorder.none,
                            ),
                          ),
                        );
                      },
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
                      controller: controller.priceController,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter price';
                        }
                        return null;
                      },
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
                    Obx(
                      () => controller.isLoading.value
                          ? const CupertinoActivityIndicator()
                          : IconButton(
                              onPressed: () {
                                controller.uploadMedia();
                              },
                              icon: const Icon(
                                Icons.send_outlined,
                                color: kPrimary,
                              ),
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
