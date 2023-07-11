import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_restaurant_fic5/bloc/add_product/add_product_bloc.dart';
import 'package:flutter_restaurant_fic5/bloc/get_all_product/get_all_product_bloc.dart';
import 'package:flutter_restaurant_fic5/bloc/gmap/gmap_bloc.dart';
import 'package:flutter_restaurant_fic5/data/local_datasources/auth_local_datasource.dart';
import 'package:flutter_restaurant_fic5/data/models/requests/add_product_request_model.dart';
import 'package:flutter_restaurant_fic5/presentation/pages/gmap_page.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class AddRestaurantPage extends StatefulWidget {
  static const routeName = '/add-restaurant';
  const AddRestaurantPage({super.key});

  @override
  State<AddRestaurantPage> createState() => _AddRestaurantPageState();
}

class _AddRestaurantPageState extends State<AddRestaurantPage> {
  TextEditingController? nameController;
  TextEditingController? addressController;
  TextEditingController? descriptionController;

  XFile? picture;

  List<XFile>? multiplePicture;

  LatLng? position;

  void takePicture(XFile file) {
    picture = file;
    setState(() {});
  }

  void takeMultiplePicture(List<XFile> files) {
    multiplePicture = files;
    setState(() {});
  }

  @override
  void initState() {
    nameController = TextEditingController();
    addressController = TextEditingController();
    descriptionController = TextEditingController();
    context.read<GmapBloc>().add(const GmapEvent.getCurrentLocation());
    super.initState();
  }

  Future<void> getImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(
      source: source,
      imageQuality: 50,
    );

    if (photo != null) {
      picture = photo;
      setState(() {});
    }
  }

  Future<void> getMultipleImage() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> photo = await picker.pickMultiImage();

    multiplePicture = photo;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Restaurant'),
        // backgroundColor: context.theme.appColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            picture != null
                ? SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.file(File(picture!.path)))
                : Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(border: Border.all()),
                  ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      // backgroundColor: context.theme.appColors.primary,
                      ),
                  onPressed: () {
                    getImage(ImageSource.gallery);
                    // getMultipleImage();
                  },
                  child: const Text(
                    "Galery",
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            BlocBuilder<GmapBloc, GmapState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  loaded: (model) {
                    position = model.latLng;
                    addressController!.text = model.address ?? '';
                    return Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextField(
                            controller: addressController,
                            decoration:
                                const InputDecoration(labelText: 'Address'),
                            maxLines: 2,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return GmapPage(
                                    lat: model.latLng!.latitude,
                                    long: model.latLng!.longitude,
                                  );
                                }));
                              },
                              child: const Text('Ganti')),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            BlocListener<AddProductBloc, AddProductState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  error: (data) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Error: $data')));
                  },
                  loaded: (model) {
                    context
                        .read<GetAllProductBloc>()
                        .add(const GetAllProductEvent.getByUserId());
                    context.pop();
                  },
                );
              },
              child: BlocBuilder<AddProductBloc, AddProductState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return ElevatedButton(
                        onPressed: () async {
                          final userId =
                              await AuthLocalDatasource().getUserId();
                          final model = AddProductRequestModel(
                              data: Data(
                            name: nameController!.text,
                            description: descriptionController!.text,
                            latitude: position == null
                                ? '0'
                                : position!.latitude.toString(),
                            longitude: position == null
                                ? '0'
                                : position!.longitude.toString(),
                            photo: 'https://picsum.photos/200/300',
                            address: addressController!.text,
                            userId: userId,
                          ));
                          context
                              .read<AddProductBloc>()
                              .add(AddProductEvent.add(model, picture!));
                        },
                        style: ElevatedButton.styleFrom(
                            // backgroundColor: context.theme.appColors.primary,
                            ),
                        child: const Text('Submit'),
                      );
                    },
                    loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
