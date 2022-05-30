import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/data/models/publish_notification_model.dart';
import 'package:salesforce/domain/entities/publish_notification.dart';
import 'package:salesforce/domain/usecases/hiveUseCases/hiveUseCases.dart';
import 'package:salesforce/error/exception.dart';
import 'package:salesforce/injectable.dart';
import 'package:salesforce/utils/apiUrl.dart';
import 'package:salesforce/utils/hiveConstant.dart';

abstract class GetAllPublishNotificationRemoteDataSource {
  Future<List<PublishNotification>> getAllPublishNotification();
}

@Injectable(as: GetAllPublishNotificationRemoteDataSource)
class GetAllPublishNotificationRemoteDataSourceImpl
    implements GetAllPublishNotificationRemoteDataSource {
  var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();
  @override
  Future<List<PublishNotification>> getAllPublishNotification() async {
    Dio dio = Dio();

    print("GetAllPublishNotificationRemoteDataSourceImpl");

    print(ApiUrl.getAllPublishNotification);

    String? accessToken;
    Box box = await Hive.openBox(HiveConstants.userdata);

    var accessTokenSuccessOrFailed =
        useCaseForHiveImpl.getValueByKey(box, "access_token");
    accessTokenSuccessOrFailed.fold((l) => {print("failed")},
        (r) => {accessToken = r!, print(r.toString())});

    print(accessToken);

    try {
      Response response = await dio.get(
        ApiUrl.getAllPublishNotification,
        options: Options(
          headers: <String, String>{'Authorization': 'Bearer ' + accessToken!},
        ),
      );

      print(response.statusCode);
      print(response.data);

      if (response.data["status"] == true) {
        print("accessTokenSuccessOrFailed");
        List<PublishNotification> notificationResponse = (response.data["data"] as List)
            .map((e) => PublishNotificationModel.fromJson(e))
            .toList();

        print(notificationResponse);
 
        return notificationResponse;
      } else {
        
        throw ServerException();
      }
    } on DioError catch (e) {
      throw ServerException();
    }
  }
}

class UserDataModel {}
