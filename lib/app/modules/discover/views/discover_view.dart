import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/discover_controller.dart';

class DiscoverView extends GetView<DiscoverController> {
  const DiscoverView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'DiscoverView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
