import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:salesforce/domain/entities/publish_notification.dart';
import 'package:salesforce/domain/usecases/hiveUseCases/hiveUseCases.dart';
import 'package:salesforce/domain/usecases/usercase_for_publish_notification.dart';
import 'package:salesforce/error/failure.dart';
import 'package:salesforce/injectable.dart';
import 'package:salesforce/utils/hiveConstant.dart';

part 'publish_notification_event.dart';
part 'publish_notification_state.dart';

class PublishNotificationBloc
    extends Bloc<PublishNotificationEvent, PublishNotificationState> {
  PublishNotificationBloc() : super(PublishNotificationInitial()) {
    var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();
    var useCaseForPublishNotificationImpl =
        getIt<UUseCaseForPublishNotificationImpl>();
    on<PublishNotificationEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetAllPublishNotificationEvent>(
      (event, emit) async {
        List<PublishNotification> notice;
        Box box = await Hive.openBox(HiveConstants.publishNotice);

        final iisSuccessful =
            await useCaseForPublishNotificationImpl.getAllPublishNotification();

        iisSuccessful.fold((l) {
          if (l is ServerFailure) {
            emit(PublishNotificationFailedState());
          } else if (l is CacheFailure) {
            emit(PublishNotificationFailedState());
          }
        }, (r) async {
          print("==========================++++++++++++++++++++");
          if (r.isNotEmpty) {
            useCaseForHiveImpl.savePublishNoticeInHive(
                box, HiveConstants.publishNotice, r);
//
            emit(PublishNotificationLoadedState(publishNotificationState: r));
          }

          // var successOrFailed = useCaseForHiveImpl.getPublishNoticeFromHive(
          //     box, HiveConstants.publishNotice);

          //     print(successOrFailed);

          // print("data is saved in hive");

          // successOrFailed.fold(
          //     (l) => {print("failed")},
          //     ((r) => { print(r),print("what is this heepno heeenoi"),
          //
          //         }));
        });
      },
    );
  }
}
