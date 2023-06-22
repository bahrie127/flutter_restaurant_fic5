part of 'detail_product_bloc.dart';

@freezed
class DetailProductEvent with _$DetailProductEvent {
  const factory DetailProductEvent.started() = _Started;
  const factory DetailProductEvent.get(int id) = _Get;
}