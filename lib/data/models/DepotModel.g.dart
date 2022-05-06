// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DepotModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepotModel _$DepotModelFromJson(Map<String, dynamic> json) => DepotModel(
      id: json['id'] as String,
      name: json['name'] as String,
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
    );

Map<String, dynamic> _$DepotModelToJson(DepotModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };
