import 'package:bloc/bloc.dart';
import 'package:flutter_restaurant_fic5/data/local_datasources/auth_local_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_restaurant_fic5/data/remote_datasources/restaurant_datasource.dart';

import '../../data/models/responses/products_response_model.dart';

part 'get_all_product_bloc.freezed.dart';
part 'get_all_product_event.dart';
part 'get_all_product_state.dart';

class GetAllProductBloc extends Bloc<GetAllProductEvent, GetAllProductState> {
  final RestaurantDatasource datasource;
  GetAllProductBloc(
    this.datasource,
  ) : super(const _Initial()) {
    on<_Get>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.getAll();
      result.fold(
        (l) => emit(const _Error()),
        (r) => emit(_Loaded(r)),
      );
    });

    on<_GetByUserId>((event, emit) async {
      emit(const _Loading());
      final userId = await AuthLocalDatasource().getUserId();
      final result = await datasource.getByUserId(userId);
      result.fold(
        (l) => emit(const _Error()),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
