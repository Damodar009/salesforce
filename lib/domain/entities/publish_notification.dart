import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'publish_notification.g.dart';

@HiveType(typeId: 14)
class PublishNotification extends Equatable {
  @HiveField(0)
  final bool? notification_status;
  @HiveField(1)
  final String? created_date;
  @HiveField(2)
  final String? path;
  @HiveField(3)
  final String? id;
  @HiveField(4)
  final String? body;
  @HiveField(5)
  final String? title;

  const PublishNotification(
      {this.path,
      this.id,
      this.body,
      this.title,
      this.created_date,
      this.notification_status});
  @override
  // TODO: implement props
  List<Object?> get props => [path, id, body, title];
}
