// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userDetailModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetailModel _$UserDetailModelFromJson(Map<String, dynamic> json) =>
    UserDetailModel(
      fullName: json['fullName'] as String,
      gender: json['gender'] as String,
      dob: json['dob'] as String,
      permanentAddress: json['permanentAddress'] as String,
      temporaryAddress: json['temporaryAddress'] as String,
      contactNumber2: json['contactNumber2'] as String,
    );

Map<String, dynamic> _$UserDetailModelToJson(UserDetailModel instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'gender': instance.gender,
      'dob': instance.dob,
      'permanentAddress': instance.permanentAddress,
      'temporaryAddress': instance.temporaryAddress,
      'contactNumber2': instance.contactNumber2,
    };
