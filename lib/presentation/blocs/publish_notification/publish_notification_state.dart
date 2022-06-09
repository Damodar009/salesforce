part of 'publish_notification_bloc.dart';

abstract class PublishNotificationState extends Equatable {
  const PublishNotificationState();

  @override
  List<Object> get props => [];
}

class PublishNotificationInitial extends PublishNotificationState {}

class PublishNotificationLoadingState extends PublishNotificationState {}

class PublishNotificationLoadedState extends PublishNotificationState {
  final List<PublishNotification> publishNotificationState;

  const PublishNotificationLoadedState(
      {required this.publishNotificationState});
}

class PublishNotificationFailedState extends PublishNotificationState {}
