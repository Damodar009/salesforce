// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageResponseModel _$ImageResponseModelFromJson(Map<String, dynamic> json) =>
    ImageResponseModel(
      id: json['id'] as String?,
      image: json['image'] as String?,
      imageType: json['imageType'] as String?,
      path: json['path'] as String?,
      uniqueKey: json['uniqueKey'] as String?,
    );

Map<String, dynamic> _$ImageResponseModelToJson(ImageResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'imageType': instance.imageType,
      'path': instance.path,
      'uniqueKey': instance.uniqueKey,
    };
