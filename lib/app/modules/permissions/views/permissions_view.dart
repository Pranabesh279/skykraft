import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:skycraft/app/widgets/buttons/gradient_button.dart';

import '../controllers/permissions_controller.dart';

class PermissionsView extends GetView<PermissionsController> {
  const PermissionsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Obx(
          () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // location permission and screen design
                    // LottieBuilder.asset('assets/location.json', height: 200),
                    const SizedBox(height: 20),
                    const Text('Location Permission',
                        style: TextStyle(fontSize: 20)),
                    const Text(
                      'We need your location to show you the best results',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 20),
                    // button to request location permission
                    GradientButton(
                      onPressed: () {
                        controller.requestLocationPermission();
                      },
                      child: controller.isLoading.value
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            )
                          : const Text(
                              'Allow Permission',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
