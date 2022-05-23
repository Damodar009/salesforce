// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchandiseOrderModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchandiseOrderModel _$MerchandiseOrderModelFromJson(
        Map<String, dynamic> json) =>
    MerchandiseOrderModel(
      image: json['image'] as String,
      description: json['description'] as String,
      merchandise_id: json['merchandise_id'] as String,
    );

Map<String, dynamic> _$MerchandiseOrderModelToJson(
        MerchandiseOrderModel instance) =>
    <String, dynamic>{
      'image': instance.image,
      'description': instance.description,
      'merchandise_id': instance.merchandise_id,
    };
