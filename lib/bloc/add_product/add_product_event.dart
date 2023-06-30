part of 'add_product_bloc.dart';

@freezed
class AddProductEvent with _$AddProductEvent {
  const factory AddProductEvent.started() = _Started;
  const factory AddProductEvent.add(
    AddProductRequestModel model,
    XFile image,
  ) = _Add;
}
