// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_image_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UploadImageResponseModel _$$_UploadImageResponseModelFromJson(
        Map<String, dynamic> json) =>
    _$_UploadImageResponseModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      alternativeText: json['alternativeText'],
      caption: json['caption'],
      width: json['width'] as int?,
      height: json['height'] as int?,
      formats: json['formats'] == null
          ? null
          : Formats.fromJson(json['formats'] as Map<String, dynamic>),
      hash: json['hash'] as String?,
      ext: json['ext'] as String?,
      mime: json['mime'] as String?,
      size: (json['size'] as num?)?.toDouble(),
      url: json['url'] as String?,
      previewUrl: json['previewUrl'],
      provider: json['provider'] as String?,
      providerMetadata: json['providerMetadata'],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$_UploadImageResponseModelToJson(
        _$_UploadImageResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'alternativeText': instance.alternativeText,
      'caption': instance.caption,
      'width': instance.width,
      'height': instance.height,
      'formats': instance.formats,
      'hash': instance.hash,
      'ext': instance.ext,
      'mime': instance.mime,
      'size': instance.size,
      'url': instance.url,
      'previewUrl': instance.previewUrl,
      'provider': instance.provider,
      'providerMetadata': instance.providerMetadata,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$_Formats _$$_FormatsFromJson(Map<String, dynamic> json) => _$_Formats(
      thumbnail: json['thumbnail'] == null
          ? null
          : Large.fromJson(json['thumbnail'] as Map<String, dynamic>),
      small: json['small'] == null
          ? null
          : Large.fromJson(json['small'] as Map<String, dynamic>),
      medium: json['medium'] == null
          ? null
          : Large.fromJson(json['medium'] as Map<String, dynamic>),
      large: json['large'] == null
          ? null
          : Large.fromJson(json['large'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_FormatsToJson(_$_Formats instance) =>
    <String, dynamic>{
      'thumbnail': instance.thumbnail,
      'small': instance.small,
      'medium': instance.medium,
      'large': instance.large,
    };

_$_Large _$$_LargeFromJson(Map<String, dynamic> json) => _$_Large(
      name: json['name'] as String?,
      hash: json['hash'] as String?,
      ext: json['ext'] as String?,
      mime: json['mime'] as String?,
      path: json['path'],
      width: json['width'] as int?,
      height: json['height'] as int?,
      size: (json['size'] as num?)?.toDouble(),
      url: json['url'] as String?,
    );

Map<String, dynamic> _$$_LargeToJson(_$_Large instance) => <String, dynamic>{
      'name': instance.name,
      'hash': instance.hash,
      'ext': instance.ext,
      'mime': instance.mime,
      'path': instance.path,
      'width': instance.width,
      'height': instance.height,
      'size': instance.size,
      'url': instance.url,
    };
