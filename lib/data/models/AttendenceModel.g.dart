// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AttendenceModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendenceModel _$AttendenceModelFromJson(Map<String, dynamic> json) =>
    AttendenceModel(
      id: json['id'] as String?,
      macAddress: json['macAddress'] as String?,
      checkin: json['checkin'] as String?,
      checkin_latitude: (json['checkin_latitude'] as num?)?.toDouble(),
      checkin_longitude: (json['checkin_longitude'] as num?)?.toDouble(),
      checkout: json['checkout'] as String?,
      checkout_latitude: (json['checkout_latitude'] as num?)?.toDouble(),
      checkout_longitude: (json['checkout_longitude'] as num?)?.toDouble(),
      user: json['user'] as String?,
    );

Map<String, dynamic> _$AttendenceModelToJson(AttendenceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'macAddress': instance.macAddress,
      'checkin': instance.checkin,
      'checkin_latitude': instance.checkin_latitude,
      'checkin_longitude': instance.checkin_longitude,
      'checkout': instance.checkout,
      'checkout_latitude': instance.checkout_latitude,
      'checkout_longitude': instance.checkout_longitude,
      'user': instance.user,
    };
