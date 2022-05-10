// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userDetailModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetailsModel _$UserDetailsModelFromJson(Map<String, dynamic> json) =>
    UserDetailsModel(
      fullName: json['fullName'] as String,
      dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
      gender: json['gender'] as String,
      path: json['path'] as String?,
      permanentAddress: json['permanentAddress'] as String,
      temporaryAddress: json['temporaryAddress'] as String,
      userDocument: json['userDocument'] as String?,
      user_detail_id: json['user_detail_id'] as String?,
      contactNumber2: json['contactNumber2'] as String,
    );

Map<String, dynamic> _$UserDetailsModelToJson(UserDetailsModel instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'gender': instance.gender,
      'dob': instance.dob?.toIso8601String(),
      'path': instance.path,
      'permanentAddress': instance.permanentAddress,
      'temporaryAddress': instance.temporaryAddress,
      'userDocument': instance.userDocument,
      'user_detail_id': instance.user_detail_id,
      'contactNumber2': instance.contactNumber2,
    };
