// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userDetailsDataModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetailsDataModel _$UserDetailsDataModelFromJson(
        Map<String, dynamic> json) =>
    UserDetailsDataModel(
      email: json['email'] as String?,
      id: json['id'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      roleId: json['roleId'] as String?,
      roleName: json['roleName'] as String?,
      status: json['status'] as bool?,
      userDetail: json['userDetail'] == null
          ? null
          : UserDetailsModel.fromJson(
              json['userDetail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDetailsDataModelToJson(
        UserDetailsDataModel instance) =>
    <String, dynamic>{
      'roleName': instance.roleName,
      'roleId': instance.roleId,
      'phoneNumber': instance.phoneNumber,
      'id': instance.id,
      'email': instance.email,
      'status': instance.status,
      'userDetail': instance.userDetail,
    };
