// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userDetailsDataModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetailsDataModel _$UserDetailsDataModelFromJson(
        Map<String, dynamic> json) =>
    UserDetailsDataModel(
      email: json['email'] as String,
      id: json['id'] as String,
      phone_number: json['phone_number'] as String,
      role_id: json['role_id'] as String,
      role_name: json['role_name'] as String,
      status: json['status'] as bool,
      userDetail:
          UserDetailsModel.fromJson(json['userDetail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDetailsDataModelToJson(
        UserDetailsDataModel instance) =>
    <String, dynamic>{
      'role_name': instance.role_name,
      'role_id': instance.role_id,
      'phone_number': instance.phone_number,
      'id': instance.id,
      'email': instance.email,
      'status': instance.status,
      'userDetail': instance.userDetail,
    };
