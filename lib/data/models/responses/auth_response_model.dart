// To parse this JSON data, do
//
//     final authResponseModel = authResponseModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'auth_response_model.freezed.dart';
part 'auth_response_model.g.dart';

@freezed
class AuthResponseModel with _$AuthResponseModel {
    const factory AuthResponseModel({
        required String jwt,
        required User user,
    }) = _AuthResponseModel;

    factory AuthResponseModel.fromJson(Map<String, dynamic> json) => _$AuthResponseModelFromJson(json);
}

@freezed
class User with _$User {
    const factory User({
        required int id,
        required String username,
        required String email,
        required String provider,
        required bool confirmed,
        required bool blocked,
        required DateTime createdAt,
        required DateTime updatedAt,
    }) = _User;

    factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
