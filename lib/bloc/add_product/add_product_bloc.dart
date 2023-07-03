import 'package:bloc/bloc.dart';
import 'package:flutter_restaurant_fic5/common/constants.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_restaurant_fic5/data/remote_datasources/restaurant_datasource.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/requests/add_product_request_model.dart';
import '../../data/models/responses/add_product_response_model.dart';

part 'add_product_bloc.freezed.dart';
part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final RestaurantDatasource datasource;
  AddProductBloc(
    this.datasource,
  ) : super(const _Initial()) {
    on<_Add>((event, emit) async {
      emit(const _Loading());
      final uploadResult = await datasource.uploadImage(event.image);
      uploadResult.fold(
        (errorUpload) => emit(_Error(errorUpload)),
        (successUpload) async {
          final result = await datasource.addProduct(AddProductRequestModel(
              data: event.model.data.copyWith(
                  photo: '${Constants.baseUrl}/${successUpload.url!}')));
          await Future.sync(() => result.fold(
                (l) => emit(_Error(l)),
                (r) => emit(_Loaded(r)),
              ));
        },
      );
    });
  }
}
