import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_restaurant_fic5/data/remote_datasources/gmap_datasource.dart';

import '../../data/models/gmap_model.dart';

part 'gmap_bloc.freezed.dart';
part 'gmap_event.dart';
part 'gmap_state.dart';

class GmapBloc extends Bloc<GmapEvent, GmapState> {
  final GmapDatasource datasource;
  GmapBloc(
    this.datasource,
  ) : super(const _Initial()) {
    on<_GetCurrentLocation>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.getCurrentPosition();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });

    on<_GetSelectPosition>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.getPosition(
        lat: event.lat,
        long: event.lat,
      );
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
