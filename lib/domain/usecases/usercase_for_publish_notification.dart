import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/domain/entities/publish_notification.dart';
import 'package:salesforce/domain/repositories/repository.dart';
import 'package:salesforce/domain/usecases/hiveUseCases/hiveUseCases.dart';
import 'package:salesforce/error/failure.dart';
import 'package:salesforce/injectable.dart';

abstract class UseCaseForPublishNotification {
  Future<Either<Failure, List<PublishNotification>>>
      getAllPublishNotification();
}

@injectable
class UUseCaseForPublishNotificationImpl
    implements UseCaseForPublishNotification {
  var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();
  var getAllPublishNotificationRepository =
      getIt<GetAllPublishNotificationRepository>();
  UUseCaseForPublishNotificationImpl();

  @override
  Future<Either<Failure, List<PublishNotification>>>
      getAllPublishNotification() async {
    return await getAllPublishNotificationRepository
        .getAllPublishNotification();
  }
}
