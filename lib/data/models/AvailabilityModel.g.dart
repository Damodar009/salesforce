// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AvailabilityModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvailabilityModel _$AvailabilityModelFromJson(Map<String, dynamic> json) =>
    AvailabilityModel(
      stock: json['stock'] as int,
      availability: json['availability'] as bool,
      product: json['product'] as String?,
    );

Map<String, dynamic> _$AvailabilityModelToJson(AvailabilityModel instance) =>
    <String, dynamic>{
      'stock': instance.stock,
      'availability': instance.availability,
      'product': instance.product,
    };
