// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Userdata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDataModel _$UserDataModelFromJson(Map<String, dynamic> json) =>
    UserDataModel(
      json['access_token'] as String,
      json['token_type'] as String,
      json['refresh_token'] as String,
      json['expires_in'] as int,
      json['scope'] as String,
      json['role'] as String,
      json['full_name'] as String?,
      json['name'] as String?,
      json['userid'] as String,
    );

Map<String, dynamic> _$UserDataModelToJson(UserDataModel instance) =>
    <String, dynamic>{
      'access_token': instance.access_token,
      'token_type': instance.token_type,
      'refresh_token': instance.refresh_token,
      'expires_in': instance.expires_in,
      'scope': instance.scope,
      'role': instance.role,
      'full_name': instance.full_name,
      'name': instance.name,
      'userid': instance.userid,
    };
