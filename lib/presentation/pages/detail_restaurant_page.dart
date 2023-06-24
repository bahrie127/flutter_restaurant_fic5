import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_restaurant_fic5/bloc/detail_product/detail_product_bloc.dart';
import 'package:flutter_restaurant_fic5/bloc/gmap/gmap_bloc.dart';
import 'package:flutter_restaurant_fic5/data/models/responses/add_product_response_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class DetailRestaurantPage extends StatefulWidget {
  static const routeName = '/detail';
  const DetailRestaurantPage({
    Key? key,
    required this.id,
  }) : super(key: key);
  final int id;

  @override
  State<DetailRestaurantPage> createState() => _DetailRestaurantPageState();
}

class _DetailRestaurantPageState extends State<DetailRestaurantPage> {
  @override
  void initState() {
    context.read<DetailProductBloc>().add(DetailProductEvent.get(widget.id));
    super.initState();
  }

  final Set<Marker> markers = {};

  void createMarker(double lat, double lng, String address) {
    final marker = Marker(
        markerId: const MarkerId('currentPosition'),
        infoWindow: InfoWindow(title: address),
        position: LatLng(lat, lng));

    markers.add(marker);
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Restaurant')),
      body: BlocBuilder<DetailProductBloc, DetailProductState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const Text('No detail'),
            loaded: (model) {
              final lat = double.parse(model.data.attributes.latitude);
              final lng = double.parse(model.data.attributes.longitude);
              print('latlng: $lat, $lng');
              createMarker(lat, lng, model.data.attributes.address);
              return ListView(
                children: [
                  Image.network(model.data.attributes.photo),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(model.data.attributes.name),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(model.data.attributes.description),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(model.data.attributes.address),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 200,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      markers: markers,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          lat,
                          lng,
                        ),
                        zoom: 15,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
