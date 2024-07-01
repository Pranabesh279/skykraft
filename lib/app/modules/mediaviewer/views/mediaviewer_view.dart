import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/mediaviewer_controller.dart';

class MediaviewerView extends GetView<MediaviewerController> {
  const MediaviewerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MediaviewerView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MediaviewerView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
