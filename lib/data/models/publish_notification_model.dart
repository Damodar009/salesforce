import 'package:json_annotation/json_annotation.dart';
import 'package:salesforce/domain/entities/publish_notification.dart';

part 'publish_notification_model.g.dart';

@JsonSerializable()

class PublishNotificationModel extends PublishNotification {
  const PublishNotificationModel({
    String? id,
    String? path,
    String? body,
    String? title,
  }) : super(id: id, path: path, body: body, title: title);

  factory PublishNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$PublishNotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$PublishNotificationModelToJson(this);
}
