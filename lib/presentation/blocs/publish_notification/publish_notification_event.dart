part of 'publish_notification_bloc.dart';

abstract class PublishNotificationEvent extends Equatable {
  const PublishNotificationEvent();

  @override
  List<Object?> get props => [];
}

class GetAllPublishNotificationEvent extends PublishNotificationEvent {
  @override
  List<Object?> get props => [];
}
