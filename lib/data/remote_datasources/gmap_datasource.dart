import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_restaurant_fic5/data/models/gmap_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo;

class GmapDatasource {
  Future<bool> _getPermission(Location location) async {
    late bool serviceEnabled;
    late PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }

    return true;
  }

  Future<Either<String, GmapModel>> getCurrentPosition() async {
    try {
      final Location location = Location();
      late LocationData locationData;

      final state = await _getPermission(location);

      if (!state) return const Left("Permission not granted");

      locationData = await location.getLocation();
      final latLng = LatLng(
        locationData.latitude!,
        locationData.longitude!,
      );

      // final info = await geo.placemarkFromCoordinates(
      //   latLng.latitude,
      //   latLng.longitude,
      // );

      // String? address;

      // if (info.isNotEmpty) {
      //   final place = info[0];
      //   address =
      //       '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
      // } else {
      //   address = "Location not found ";
      // }

      return Right(GmapModel(
        latLng: latLng,
        address: 'address',
      ));
    } on PlatformException catch (e) {
      if (e.code == 'IO_ERROR') {
        debugPrint(
            'A network error occurred trying to lookup the supplied coordinates: ${e.message}');
      } else {
        debugPrint('Failed to lookup coordinates: ${e.message}');
      }
      return Left(e.message!);
    } catch (e) {
      debugPrint('An unknown error occurred: $e');
      return Left(e.toString());
    }
  }

  Future<Either<String, GmapModel>> getPosition(
      {required double lat, required double long}) async {
    final Location location = Location();
    late LocationData locationData;
    final state = await _getPermission(location);

    if (!state) return const Left("Permission not granted");
    locationData = await location.getLocation();
    final latLng = LatLng(
      locationData.latitude!,
      locationData.longitude!,
    );

    final info = await geo.placemarkFromCoordinates(
      lat,
      long,
    );

    String? address;
    if (info.isNotEmpty) {
      final place = info[0];
      address =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    } else {
      address = "Location not found ";
    }

    return Right(GmapModel(
      latLng: latLng,
      address: address,
    ));
  }
}
