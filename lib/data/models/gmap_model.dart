import 'package:google_maps_flutter/google_maps_flutter.dart';

class GmapModel {
  LatLng? latLng;
  String? address;
  GmapModel({
    this.latLng,
    this.address,
  });

  @override
  String toString() => 'GmapModel(latLng: $latLng, address: $address)';
}
