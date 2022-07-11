// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AttendenceDashBoardModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceDashboardModel _$AttendanceDashboardModelFromJson(
        Map<String, dynamic> json) =>
    AttendanceDashboardModel(
      (json['percentile'] as num).toDouble(),
      (json['present_days'] as num).toDouble(),
      (json['absent_days'] as num).toDouble(),
    );

Map<String, dynamic> _$AttendanceDashboardModelToJson(
        AttendanceDashboardModel instance) =>
    <String, dynamic>{
      'percentile': instance.percentile,
      'present_days': instance.present_days,
      'absent_days': instance.absent_days,
    };
