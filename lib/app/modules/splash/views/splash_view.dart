import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.only(bottom: 100),
                child: Image.asset(
                  'assets/Splash-light.png',
                ),
              ),
            ),
            if (controller.isLoading.value)
              const Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                        strokeWidth: 1,
                      ),
                    )),
              ),
          ],
        ),
      ),
    );
  }
}
