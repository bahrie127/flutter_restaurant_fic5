// To parse this JSON data, do
//
//     final addProductRequestModel = addProductRequestModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'add_product_request_model.freezed.dart';
part 'add_product_request_model.g.dart';

@freezed
class AddProductRequestModel with _$AddProductRequestModel {
    const factory AddProductRequestModel({
        required Data data,
    }) = _AddProductRequestModel;

    factory AddProductRequestModel.fromJson(Map<String, dynamic> json) => _$AddProductRequestModelFromJson(json);
}

@freezed
class Data with _$Data {
    const factory Data({
        required String name,
        required String description,
        required String latitude,
        required String longitude,
        required String photo,
        required String address,
        required int userId,
    }) = _Data;

    factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}
