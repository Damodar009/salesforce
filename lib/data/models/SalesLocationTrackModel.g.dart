// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SalesLocationTrackModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesLocationTrackModel _$SalesLocationTrackModelFromJson(
        Map<String, dynamic> json) =>
    SalesLocationTrackModel(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      trackingDate: json['trackingDate'] as String,
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$SalesLocationTrackModelToJson(
        SalesLocationTrackModel instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'trackingDate': instance.trackingDate,
      'userId': instance.userId,
    };
