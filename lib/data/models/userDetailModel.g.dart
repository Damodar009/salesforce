// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userDetailModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetailsModel _$UserDetailsModelFromJson(Map<String, dynamic> json) =>
    UserDetailsModel(
      fullName: json['fullName'] as String?,
      id: json['id'] as String?,
      dob: json['dob'] as String?,
      gender: json['gender'] as String?,
      path: json['path'] as String?,
      permanentAddress: json['permanentAddress'] as String?,
      temporaryAddress: json['temporaryAddress'] as String?,
      userDocument: json['userDocument'] as String?,
      user_detail_id: json['user_detail_id'] as String?,
      contactNumber2: json['contactNumber2'] as String?,
      designationId: json['designationId'] as String?,
      employee_contract: json['employee_contract'] as String?,
    );

Map<String, dynamic> _$UserDetailsModelToJson(UserDetailsModel instance) =>
    <String, dynamic>{
      'designationId': instance.designationId,
      'id': instance.id,
      'fullName': instance.fullName,
      'gender': instance.gender,
      'dob': instance.dob,
      'path': instance.path,
      'permanentAddress': instance.permanentAddress,
      'temporaryAddress': instance.temporaryAddress,
      'userDocument': instance.userDocument,
      'user_detail_id': instance.user_detail_id,
      'contactNumber2': instance.contactNumber2,
      'employee_contract': instance.employee_contract,
    };
