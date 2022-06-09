// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publish_notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublishNotificationModel _$PublishNotificationModelFromJson(
        Map<String, dynamic> json) =>
    PublishNotificationModel(
      notification_status: json['notification_status'] as bool?,
      created_date: json['created_date'] as String?,
      id: json['id'] as String?,
      path: json['path'] as String?,
      body: json['body'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$PublishNotificationModelToJson(
        PublishNotificationModel instance) =>
    <String, dynamic>{
      'notification_status': instance.notification_status,
      'created_date': instance.created_date,
      'path': instance.path,
      'id': instance.id,
      'body': instance.body,
      'title': instance.title,
    };
