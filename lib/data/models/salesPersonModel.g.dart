// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'salesPersonModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesPersonModel _$SalesPersonModelFromJson(Map<String, dynamic> json) =>
    SalesPersonModel(
      id: json['id'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      password: json['password'] as String,
      roleId: json['roleId'] as String,
      userDetails:
          UserDetailModel.fromJson(json['userDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SalesPersonModelToJson(SalesPersonModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
      'roleId': instance.roleId,
      'userDetails': instance.userDetails.toJson(),
    };
