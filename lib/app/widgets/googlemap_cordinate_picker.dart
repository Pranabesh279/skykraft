import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:skycraft/app/constants/theme_data.dart';

class GoogleMapCordinatePicker extends StatelessWidget {
  final LatLng initialCordinate;
  final Function(LatLng) onCordinateChanged;
  final bool changeCordinateOnDrag;
  const GoogleMapCordinatePicker(
      {super.key,
      this.changeCordinateOnDrag = true,
      required this.initialCordinate,
      required this.onCordinateChanged});

  @override
  Widget build(BuildContext context) {
    GoogleMapController? controller;
    return SizedBox(
      child: Stack(
        children: [
          GoogleMap(
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: initialCordinate,
                zoom: 15,
              ),
              onCameraMoveStarted: () {
                log('onCameraMoveStarted');
                log(controller!.getVisibleRegion().toString());
              },
              onMapCreated: (GoogleMapController c) {
                controller = c;
              },
              onCameraMove: (CameraPosition cameraPosition) {
                if (changeCordinateOnDrag) {
                  onCordinateChanged(cameraPosition.target);
                }
              },
              circles: {
                Circle(
                  circleId: const CircleId('1'),
                  center: initialCordinate,
                  radius: 500,
                  fillColor: kPrimaryColor.withOpacity(0.15),
                  strokeWidth: 0,
                ),
              }),
          Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.location_on,
                    color: kPrimaryColor,
                    size: 40,
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      'Drag to set location',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
