// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetailsModel _$UserDetailsModelFromJson(Map<String, dynamic> json) =>
    UserDetailsModel(
      full_name: json['full_name'] as String,
      gender: json['gender'] as String,
      path: json['path'] as String,
      permanent_address: json['permanent_address'] as String,
      temporary_address: json['temporary_address'] as String,
      user_details_id: json['user_details_id'] as String,
      contact_number: json['contact_number'] as String,
    );

Map<String, dynamic> _$UserDetailsModelToJson(UserDetailsModel instance) =>
    <String, dynamic>{
      'full_name': instance.full_name,
      'gender': instance.gender,
      'path': instance.path,
      'permanent_address': instance.permanent_address,
      'temporary_address': instance.temporary_address,
      'user_details_id': instance.user_details_id,
      'contact_number': instance.contact_number,
    };
