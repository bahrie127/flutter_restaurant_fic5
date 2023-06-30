import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../data/models/direction.dart';

class DirectionPage extends StatefulWidget {
  const DirectionPage({
    Key? key,
    required this.startLocation,
    required this.destinationLocation,
  }) : super(key: key);
  final LatLng startLocation;
  final LatLng destinationLocation;

  @override
  State<DirectionPage> createState() => _DirectionPageState();
}

class _DirectionPageState extends State<DirectionPage> {
  late GoogleMapController mapController;
  late final Set<Marker> markers = {};

  final Set<Polyline> polylines = <Polyline>{};

  final Location location = Location();

  bool isNavigationOn = false;

  Future<void> setupLocation() async {
    late bool serviceEnabled;
    late PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        debugPrint('location service is not available');
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.denied) {
        debugPrint('Location permission is denied');
        return;
      }
    }
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await setupLocation();
    });

    location.onLocationChanged.listen((event) {
      if (isNavigationOn) {
        final latLng = LatLng(event.latitude!, event.longitude!);

        CameraPosition cameraPosition = CameraPosition(
          target: latLng,
          zoom: 16,
          tilt: 80,
          bearing: 30,
        );

        mapController.animateCamera(
          CameraUpdate.newCameraPosition(cameraPosition),
        );

        setState(() {
          markers.removeWhere((element) => element.markerId.value == 'source');
          markers.add(
            Marker(
              markerId: const MarkerId('source'),
              position: latLng,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueOrange,
              ),
            ),
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: widget.startLocation,
              zoom: 18,
            ),
            markers: markers,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            myLocationButtonEnabled: false,
            polylines: polylines,
            onMapCreated: (controller) {
              final startMarker = Marker(
                markerId: const MarkerId('source'),
                position: widget.startLocation,
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueYellow,
                ),
              );
              final destinationMarker = Marker(
                markerId: const MarkerId('destination'),
                position: widget.destinationLocation,
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueYellow,
                ),
              );

              setState(() {
                mapController = controller;
                markers.addAll([startMarker, destinationMarker]);
              });
            },
          ),
          Positioned(
              bottom: 16,
              right: 16,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                    onPressed: () async {
                      setState(() {
                        isNavigationOn = false;
                        markers.removeWhere(
                            (element) => element.markerId.value == 'source');
                        markers.add(
                          Marker(
                            markerId: const MarkerId('source'),
                            position: widget.startLocation,
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueRed,
                            ),
                          ),
                        );
                      });
                      await setPolylines(
                        widget.startLocation,
                        widget.destinationLocation,
                      );
                    },
                    child: const Icon(Icons.directions),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        isNavigationOn = true;
                      });
                    },
                    child: const Icon(Icons.navigation),
                  )
                ],
              ))
        ],
      )),
    );
  }

  Future<void> setPolylines(LatLng origin, LatLng destination) async {
    final result = await Direction.getDirections(
      googleMapsApiKey: 'AIzaSyCvLVqdIcaudtHhsMKkbE6T22Oxb9wMLQw',
      origin: origin,
      destination: destination,
    );

    final polylineCoordinates = <LatLng>[];
    if (result != null && result.polylinePoints.isNotEmpty) {
      polylineCoordinates.addAll(result.polylinePoints);
    }

    final polyline = Polyline(
      polylineId: const PolylineId('default-polyline'),
      color: Colors.blue,
      width: 7,
      points: polylineCoordinates,
    );

    setState(() {
      polylines.add(polyline);
    });

    mapController.animateCamera(
      CameraUpdate.newLatLngBounds(result!.bounds, 50),
    );
  }
}
