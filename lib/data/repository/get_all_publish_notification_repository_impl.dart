import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/data/datasource/remoteSource/get_all_publish_notification_remote_data_source.dart';
import 'package:salesforce/domain/entities/publish_notification.dart';
import 'package:salesforce/domain/repositories/repository.dart';
import 'package:salesforce/error/failure.dart';
import 'package:salesforce/injectable.dart';

@Injectable(as: GetAllPublishNotificationRepository)
class GetAllPublishNotificationRepositoryImpl
    implements GetAllPublishNotificationRepository {
      
  final getAllPublishNotificationRemoteDataSource =
      getIt<GetAllPublishNotificationRemoteDataSource>();
  @override
  Future<Either<Failure, List<PublishNotification>>>
      getAllPublishNotification() async {
    try {
      final publishNotificationResponse =
          await getAllPublishNotificationRemoteDataSource
              .getAllPublishNotification();

      return Right(publishNotificationResponse);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
