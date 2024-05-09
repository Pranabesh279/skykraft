import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/address_input_controller.dart';

class AddressInputBinding extends Bindings {
  final LatLng? initialCordinate;

  AddressInputBinding({this.initialCordinate});
  @override
  void dependencies() {
    Get.lazyPut<AddressInputController>(
      () => AddressInputController(
        initialCordinate: initialCordinate,
      ),
    );
  }
}
