// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaveModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveModel _$LeaveModelFromJson(Map<String, dynamic> json) => LeaveModel(
      fromDate: json['from_date'] as String,
      toDate: json['to_date'] as String,
      userId: json['user_id'] as String,
      reason: json['reason'] as String,
    );

Map<String, dynamic> _$LeaveModelToJson(LeaveModel instance) =>
    <String, dynamic>{
      'from_date': instance.fromDate,
      'to_date': instance.toDate,
      'user_id': instance.userId,
      'reason': instance.reason,
    };
