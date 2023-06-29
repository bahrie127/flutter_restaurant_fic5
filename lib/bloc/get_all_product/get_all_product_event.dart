part of 'get_all_product_bloc.dart';

@freezed
class GetAllProductEvent with _$GetAllProductEvent {
  const factory GetAllProductEvent.started() = _Started;
  const factory GetAllProductEvent.get() = _Get;
  const factory GetAllProductEvent.getByUserId() = _GetByUserId;
}
