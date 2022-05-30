import 'package:equatable/equatable.dart';

class PublishNotification extends Equatable {
  final String? path;
  final String? id;
  final String? body;
  final String? title;

  const PublishNotification({this.path, this.id, this.body, this.title});
  @override
  // TODO: implement props
  List<Object?> get props => [path, id, body, title];
}
