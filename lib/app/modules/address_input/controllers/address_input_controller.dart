import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:skycraft/app/models/addresss_data.dart';
import 'package:geocoder2/geocoder2.dart';

class AddressInputController extends GetxController {
  Rx<bool> isLoading = false.obs;
  final LatLng? initialCordinate;
  final Rx<LatLng?> cordinate = Rx<LatLng?>(null);
  Rx<AddressData?> addressData = Rx<AddressData?>(null);

  AddressInputController({this.initialCordinate});

  @override
  void onInit() {
    super.onInit();
    if (initialCordinate != null) {
      cordinate.value = initialCordinate;
      updateAddressData(initialCordinate!);
    }
    ever(cordinate, (LatLng? latLng) {
      if (latLng != null) {
        updateAddressData(latLng);
      }
    });
  }

  void updateAddressData(LatLng latLng) async {
    if (isLoading.value) return;
    isLoading.value = true;
    try {
      cordinate.value = latLng;
      final add = await getAddressFromCordinate(latLng);
      addressData.value = add;
    } catch (e) {
      log('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void onCordinateChanged(LatLng latLng) {
    cordinate.value = latLng;
  }

  void saveAddressData() async {
    isLoading.value = true;
    final address = await getAddressFromCordinate(cordinate.value!);
    addressData.value = address;
    isLoading.value = false;
  }

  Future<AddressData> getAddressFromCordinate(LatLng latLng) async {
    final geoPoint = GeoPoint(latLng.latitude, latLng.longitude);
    final address = await getAddressFromGeoPoint(geoPoint);
    return AddressData(
      geoPoint: geoPoint,
      address: address['address'],
      landmark: address['landmark'],
      city: address['city'],
      state: address['state'],
      country: address['country'],
      pincode: address['pincode'],
      lat: latLng.latitude.toString(),
      long: latLng.longitude.toString(),
    );
  }

  Future<Map<String, String>> getAddressFromGeoPoint(GeoPoint geoPoint) async {
    final address = await Geocoder2.getDataFromCoordinates(
      latitude: geoPoint.latitude,
      longitude: geoPoint.longitude,
      googleMapApiKey: 'AIzaSyBiyJLmU_wJpd0qDR2y9NVA4BtKlmAB2bQ',
    );
    return {
      'address': address.address,
      'landmark': address.streetNumber,
      'city': address.city,
      'state': address.state,
      'country': address.country,
      'pincode': address.postalCode,
    };
  }
}
