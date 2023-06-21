// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RegisterRequestModel _$$_RegisterRequestModelFromJson(
        Map<String, dynamic> json) =>
    _$_RegisterRequestModel(
      name: json['name'] as String,
      password: json['password'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
    );

Map<String, dynamic> _$$_RegisterRequestModelToJson(
        _$_RegisterRequestModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'password': instance.password,
      'email': instance.email,
      'username': instance.username,
    };
