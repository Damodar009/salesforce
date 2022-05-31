import 'package:equatable/equatable.dart';

class PublishNotification extends Equatable {
  final bool? notification_status;
  final String? created_date;
  final String? path;
  final String? id;
  final String? body;
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
