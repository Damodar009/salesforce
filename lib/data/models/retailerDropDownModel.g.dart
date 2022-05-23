// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retailerDropDownModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RetailerDropDownModel _$RetailerDropDownModelFromJson(
        Map<String, dynamic> json) =>
    RetailerDropDownModel(
      name: json['name'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'] as String,
      contact_person: json['contact_person'] as String,
      contact_number: json['contact_number'] as String,
      retailer_class: json['retailer_class'] as String,
      retailer_type_name: json['retailer_type_name'] as String,
      id: json['id'] as String,
      retailer_type_id: json['retailer_type_id'] as String,
      status: json['status'] as bool,
    );

Map<String, dynamic> _$RetailerDropDownModelToJson(
        RetailerDropDownModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'contact_person': instance.contact_person,
      'contact_number': instance.contact_number,
      'retailer_class': instance.retailer_class,
      'retailer_type_name': instance.retailer_type_name,
      'id': instance.id,
      'retailer_type_id': instance.retailer_type_id,
      'status': instance.status,
    };
