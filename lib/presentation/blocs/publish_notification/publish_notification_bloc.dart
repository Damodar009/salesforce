import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salesforce/domain/entities/publish_notification.dart';
import 'package:salesforce/domain/usecases/usercase_for_publish_notification.dart';
import 'package:salesforce/error/failure.dart';
import 'package:salesforce/injectable.dart';

part 'publish_notification_event.dart';
part 'publish_notification_state.dart';

class PublishNotificationBloc
    extends Bloc<PublishNotificationEvent, PublishNotificationState> {
  PublishNotificationBloc() : super(PublishNotificationInitial()) {
    var useCaseForPublishNotificationImpl =
        getIt<UUseCaseForPublishNotificationImpl>();
    on<PublishNotificationEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetAllPublishNotificationEvent>(
      (event, emit) async {
        final iisSuccessful =
            await useCaseForPublishNotificationImpl.getAllPublishNotification();

            print("you are in bloc");

        iisSuccessful.fold((l) {
          if (l is ServerFailure) {
            emit(PublishNotificationFailedState());
          } else if (l is CacheFailure) {
            emit(PublishNotificationFailedState());
          }
        }, (r) {
          print(r);
          emit(PublishNotificationLoadedState(publishNotificationState: r));
        });
      },
    );
  }
}
