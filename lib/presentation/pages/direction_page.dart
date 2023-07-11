import 'package:flutter/material.dart';
import 'package:flutter_restaurant_fic5/data/models/direction.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class DirectionPage extends StatefulWidget {
  const DirectionPage({
    Key? key,
    required this.origin,
    required this.destination,
  }) : super(key: key);

  final LatLng origin;
  final LatLng destination;

  @override
  State<DirectionPage> createState() => _DirectionPageState();
}

class _DirectionPageState extends State<DirectionPage> {
  late GoogleMapController mapController;
  late final Set<Marker> markers = {};

  final Set<Polyline> polylines = <Polyline>{};

  final Location location = Location();

  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(10, 10)),
            "assets/markers/car.png")
        .then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

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
      if (permissionGranted == PermissionStatus.denied) {
        debugPrint('Location permission is denied');
        return;
      }
    }
  }

  bool isNavigationOn = false;

  @override
  void initState() {
    addCustomIcon();
    super.initState();

    Future.microtask(() async {
      await setupLocation();
    });

    location.onLocationChanged.listen((event) {
      print('active');
      if (isNavigationOn) {
        print('active on');
        final latlng = LatLng(event.latitude!, event.longitude!);

        CameraPosition cameraPosition = CameraPosition(
          target: latlng,
          zoom: 16,
          tilt: 80,
          bearing: 30,
        );

        mapController.animateCamera(
          CameraUpdate.newCameraPosition(cameraPosition),
        );

        setState(() {
          markers.removeWhere((element) => element.markerId.value == 'source');
          markers.add(Marker(
            markerId: const MarkerId('source'),
            position: latlng,
            icon: markerIcon,
          ));
        });
      }
    });
  }

  Future<void> setPolylines(LatLng origin, LatLng destination) async {
    final result = await Direction.getDirections(
      googleMapsApiKey: 'AIzaSyAkAU2Dx4hz-X1OAFzGy38q15V9Miw0gkA',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: widget.origin,
                zoom: 18,
              ),
              markers: markers,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              myLocationButtonEnabled: false,
              polylines: polylines,
              onMapCreated: (controller) {
                final originMarker = Marker(
                  markerId: const MarkerId('source'),
                  position: widget.origin,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueRed,
                  ),
                );

                final destinationMarker = Marker(
                  markerId: const MarkerId('destination'),
                  position: widget.destination,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueRed,
                  ),
                );

                setState(() {
                  mapController = controller;
                  markers.addAll([originMarker, destinationMarker]);
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
                        markers.removeWhere(
                            (element) => element.markerId.value == 'source');
                        markers.add(Marker(
                            markerId: const MarkerId('source'),
                            position: widget.origin,
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueRed)));
                        markers.add(Marker(
                            markerId: const MarkerId('des'),
                            position: widget.destination,
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueRed)));
                        setState(() {});
                        await setPolylines(widget.origin, widget.destination);
                      },
                      child: const Icon(Icons.navigation),
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
                      child: const Icon(Icons.run_circle),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
