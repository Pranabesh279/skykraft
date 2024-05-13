import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:skycraft/app/widgets/buttons/mapButtons.dart';

import '../controllers/home_controller.dart';

// intialize position of the map lat-24.115294841764197 long 78.64444602280855 zoom 4.479615688323975 bearing 0.0  tilt 0.0
class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Obx(
              () => GoogleMap(
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                myLocationButtonEnabled: false,
                myLocationEnabled: false,
                mapType: MapType.normal,
                initialCameraPosition: controller.kInitialPosition.value,
                indoorViewEnabled: true,
                onMapCreated: (GoogleMapController c) {
                  controller.mapController.complete(c);
                },
                onCameraMove: (position) {
                  log('camera position: ${position.target.latitude}, ${position.target.longitude} ');
                  controller.kInitialPosition.value = position;
                },
                markers: controller.selectedIndex.value == 0
                    ? Set<Marker>.of(controller.userMarkers.value)
                    : Set<Marker>.of(controller.postMarkers.value),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() => MapTabView(
                            onItemTapped: (int i) {
                              controller.selectedIndex.value = i;
                            },
                            selectedIndex: controller.selectedIndex.value,
                            tabs: const [
                              'Pilots',
                              // 'Locations',
                            ],
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
