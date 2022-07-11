// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaveModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveModel _$LeaveModelFromJson(Map<String, dynamic> json) => LeaveModel(
      fromDate: json['fromDate'] as String,
      toDate: json['toDate'] as String,
      userId: json['userId'] as String,
      reason: json['reason'] as String,
    );

Map<String, dynamic> _$LeaveModelToJson(LeaveModel instance) =>
    <String, dynamic>{
      'fromDate': instance.fromDate,
      'toDate': instance.toDate,
      'userId': instance.userId,
      'reason': instance.reason,
    };
