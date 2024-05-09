import 'package:cloud_firestore/cloud_firestore.dart';

class AddressData {
  final GeoPoint? geoPoint;
  final String? address;
  final String? landmark;
  final String? city;
  final String? state;
  final String? country;
  final String? pincode;
  final String? lat;
  final String? long;

  AddressData(
      {required this.geoPoint,
      required this.address,
      required this.landmark,
      required this.city,
      required this.state,
      required this.country,
      required this.pincode,
      required this.lat,
      required this.long});

  factory AddressData.fromMap(Map<String, dynamic> map) {
    return AddressData(
      geoPoint: map['geoPoint'] as GeoPoint?,
      address: map['address'] as String?,
      landmark: map['landmark'] as String?,
      city: map['city'] as String?,
      state: map['state'] as String?,
      country: map['country'] as String?,
      pincode: map['pincode'] as String?,
      lat: map['lat'] as String?,
      long: map['long'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'geoPoint': geoPoint,
      'address': address,
      'landmark': landmark,
      'city': city,
      'state': state,
      'country': country,
      'pincode': pincode,
      'lat': lat,
      'long': long,
    };
  }
}
