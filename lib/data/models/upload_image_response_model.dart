// To parse this JSON data, do
//
//     final uploadImageResponseModel = uploadImageResponseModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'upload_image_response_model.freezed.dart';
part 'upload_image_response_model.g.dart';

@freezed
class UploadImageResponseModel with _$UploadImageResponseModel {
  const factory UploadImageResponseModel({
    int? id,
    String? name,
    dynamic alternativeText,
    dynamic caption,
    int? width,
    int? height,
    Formats? formats,
    String? hash,
    String? ext,
    String? mime,
    double? size,
    String? url,
    dynamic previewUrl,
    String? provider,
    dynamic providerMetadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UploadImageResponseModel;

  factory UploadImageResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UploadImageResponseModelFromJson(json);
}

@freezed
class Formats with _$Formats {
  const factory Formats({
    Large? thumbnail,
    Large? small,
    Large? medium,
    Large? large,
  }) = _Formats;

  factory Formats.fromJson(Map<String, dynamic> json) =>
      _$FormatsFromJson(json);
}

@freezed
class Large with _$Large {
  const factory Large({
    String? name,
    String? hash,
    String? ext,
    String? mime,
    dynamic path,
    int? width,
    int? height,
    double? size,
    String? url,
  }) = _Large;

  factory Large.fromJson(Map<String, dynamic> json) => _$LargeFromJson(json);
}
