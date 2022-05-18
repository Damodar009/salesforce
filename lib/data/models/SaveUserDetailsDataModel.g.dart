// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SaveUserDetailsDataModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveUserDetailsDataModel _$SaveUserDetailsDataModelFromJson(
        Map<String, dynamic> json) =>
    SaveUserDetailsDataModel(
      id: json['id'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      password: json['password'] as String?,
      roleId: json['roleId'] as String?,
      roleName: json['roleName'] as String?,
      userDetail: json['userDetail'] == null
          ? null
          : UserDetailsModel.fromJson(
              json['userDetail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SaveUserDetailsDataModelToJson(
        SaveUserDetailsDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
      'roleId': instance.roleId,
      'roleName': instance.roleName,
      'userDetail': instance.userDetail,
    };
