// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LoginRequestModel _$LoginRequestModelFromJson(Map<String, dynamic> json) {
  return _LoginRequestModel.fromJson(json);
}

/// @nodoc
mixin _$LoginRequestModel {
  String get identifier => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoginRequestModelCopyWith<LoginRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginRequestModelCopyWith<$Res> {
  factory $LoginRequestModelCopyWith(
          LoginRequestModel value, $Res Function(LoginRequestModel) then) =
      _$LoginRequestModelCopyWithImpl<$Res, LoginRequestModel>;
  @useResult
  $Res call({String identifier, String password});
}

/// @nodoc
class _$LoginRequestModelCopyWithImpl<$Res, $Val extends LoginRequestModel>
    implements $LoginRequestModelCopyWith<$Res> {
  _$LoginRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identifier = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      identifier: null == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LoginRequestModelCopyWith<$Res>
    implements $LoginRequestModelCopyWith<$Res> {
  factory _$$_LoginRequestModelCopyWith(_$_LoginRequestModel value,
          $Res Function(_$_LoginRequestModel) then) =
      __$$_LoginRequestModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String identifier, String password});
}

/// @nodoc
class __$$_LoginRequestModelCopyWithImpl<$Res>
    extends _$LoginRequestModelCopyWithImpl<$Res, _$_LoginRequestModel>
    implements _$$_LoginRequestModelCopyWith<$Res> {
  __$$_LoginRequestModelCopyWithImpl(
      _$_LoginRequestModel _value, $Res Function(_$_LoginRequestModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identifier = null,
    Object? password = null,
  }) {
    return _then(_$_LoginRequestModel(
      identifier: null == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LoginRequestModel implements _LoginRequestModel {
  const _$_LoginRequestModel(
      {required this.identifier, required this.password});

  factory _$_LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$$_LoginRequestModelFromJson(json);

  @override
  final String identifier;
  @override
  final String password;

  @override
  String toString() {
    return 'LoginRequestModel(identifier: $identifier, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LoginRequestModel &&
            (identical(other.identifier, identifier) ||
                other.identifier == identifier) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, identifier, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LoginRequestModelCopyWith<_$_LoginRequestModel> get copyWith =>
      __$$_LoginRequestModelCopyWithImpl<_$_LoginRequestModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LoginRequestModelToJson(
      this,
    );
  }
}

abstract class _LoginRequestModel implements LoginRequestModel {
  const factory _LoginRequestModel(
      {required final String identifier,
      required final String password}) = _$_LoginRequestModel;

  factory _LoginRequestModel.fromJson(Map<String, dynamic> json) =
      _$_LoginRequestModel.fromJson;

  @override
  String get identifier;
  @override
  String get password;
  @override
  @JsonKey(ignore: true)
  _$$_LoginRequestModelCopyWith<_$_LoginRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}
