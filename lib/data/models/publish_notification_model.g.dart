// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publish_notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublishNotificationModel _$PublishNotificationModelFromJson(
        Map<String, dynamic> json) =>
    PublishNotificationModel(
      id: json['id'] as String?,
      path: json['path'] as String?,
      body: json['body'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$PublishNotificationModelToJson(
        PublishNotificationModel instance) =>
    <String, dynamic>{
      'path': instance.path,
      'id': instance.id,
      'body': instance.body,
      'title': instance.title,
    };
