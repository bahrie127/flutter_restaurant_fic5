part of 'gmap_bloc.dart';

@freezed
class GmapEvent with _$GmapEvent {
  const factory GmapEvent.started() = _Started;
  const factory GmapEvent.getCurrentLocation() = _GetCurrentLocation;
  const factory GmapEvent.getSelectPosition(double lat, double long) = _GetSelectPosition;

}