import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:skycraft/app/widgets/buttons/gradient_button.dart';

import '../controllers/location_permission_controller.dart';

class LocationPermissionView extends GetView<LocationPermissionController> {
  const LocationPermissionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: const EdgeInsets.only(
            top: 50,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              const Image(
                image: AssetImage('assets/icons/map.png'),
                height: 60,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Location Permission',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              // location permission help us for improve booking experience and upadate your location on the map

              const Text(
                'Location permission help us for improve booking experience and upadate your location on the map',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'This app needs location permission to work properly',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Obx(
                () => controller.isLocationserviceEnabled.value
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check,
                            color: Colors.green,
                            size: 14,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Location service is enabled',
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 14,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Location service is disabled',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => controller.isLocationPermissionGranted.value
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check,
                            color: Colors.green,
                            size: 14,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Location permission is granted',
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 14,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Location permission is denied',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
              ),
              const Spacer(),
              Obx(
                () => GradientButton(
                    isLoading: controller.isLoading.value,
                    // disable: !controller.isChecked.value,
                    onPressed: () {
                      controller.allowPermission();
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
              ),
            ],
          )),
    );
  }
}
