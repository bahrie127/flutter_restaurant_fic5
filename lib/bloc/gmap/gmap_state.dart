part of 'gmap_bloc.dart';

@freezed
class GmapState with _$GmapState {
  const factory GmapState.initial() = _Initial;
  const factory GmapState.loading() = _Loading;
  const factory GmapState.loaded(GmapModel model) = _Loaded;
  const factory GmapState.error(String error) = _Error;
}
