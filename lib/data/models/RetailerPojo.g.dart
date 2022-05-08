// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RetailerPojo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RetailerPojoModel _$RetailerPojoModelFromJson(Map<String, dynamic> json) =>
    RetailerPojoModel(
      name: json['name'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'] as String,
      contactPerson: json['contactPerson'] as String,
      contactNumber: json['contactNumber'] as String,
      retailerClass: json['retailerClass'] as String,
      retailerType: json['retailerType'] as String,
      region: json['region'] as String,
    );

Map<String, dynamic> _$RetailerPojoModelToJson(RetailerPojoModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'contactPerson': instance.contactPerson,
      'contactNumber': instance.contactNumber,
      'retailerClass': instance.retailerClass,
      'retailerType': instance.retailerType,
      'region': instance.region,
    };
