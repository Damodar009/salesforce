// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Model _$ModelFromJson(Map<String, dynamic> json) => Model(
      name: json['name'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$ModelToJson(Model instance) => <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
    };
