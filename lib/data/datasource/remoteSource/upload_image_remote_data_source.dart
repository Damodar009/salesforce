import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/error/exception.dart';
import 'package:salesforce/utils/apiUrl.dart';
import '../../../domain/usecases/hiveUseCases/hiveUseCases.dart';
import '../../../injectable.dart';
import '../../../utils/AapiUtils.dart';

abstract class UploadImageRemoteDataSource {
  Future<String> uploadImageSave(String imageName);
}

@Injectable(as: UploadImageRemoteDataSource)
class UploadImageRemoteDataSourceImpl implements UploadImageRemoteDataSource {
  Dio dio = Dio();

  var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();
  String image = "";

  @override
  Future<String> uploadImageSave(String imageName) async {
    try {
      String? accessToken;
      AppInterceptors appInterceptors = AppInterceptors();
      accessToken = await appInterceptors.getUserAccessToken();

      FormData data = FormData.fromMap({
        "image": await MultipartFile.fromFile(imageName),
      });
      Response response = await dio.post(
        ApiUrl.imageUpload,
        data: data,
        options: Options(
          contentType: "multipart/form-data",
          headers: <String, String>{'Authorization': 'Bearer ' + accessToken!},
        ),
      );
      if (response.data["status"] == true) {
        String imageResponse = response.data["data"]["id"];
        return imageResponse;
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw ServerException();
    }
  }
}
