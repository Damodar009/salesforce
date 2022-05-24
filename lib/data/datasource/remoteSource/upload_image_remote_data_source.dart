import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/data/models/image_response_model.dart';
import 'package:salesforce/domain/entities/image.dart';
import 'package:salesforce/error/exception.dart';
import 'package:salesforce/utils/apiUrl.dart';

import '../../../domain/usecases/hiveUseCases/hiveUseCases.dart';
import '../../../injectable.dart';
import '../../../utils/hiveConstant.dart';

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
      print("upload image repo");
      print(ApiUrl.imageUpload);

      print("image :$imageName");

      String? accessToken;
      Box box = await Hive.openBox(HiveConstants.userdata);

      var accessTokenSuccessOrFailed =
          useCaseForHiveImpl.getValueByKey(box, "access_token");
      accessTokenSuccessOrFailed.fold((l) => {print("failed")},
          (r) => {accessToken = r!, print(r.toString())});

      /*String fileName = imageName.split('/').last;*/

      FormData data = FormData.fromMap({
        "image": await MultipartFile.fromFile(imageName),
      });

      print(data);

      print("you have reached here man");
      Response response = await dio.post(
        ApiUrl.imageUpload,
        data: data,
        options: Options(
          contentType: "multipart/form-data",
          headers: <String, String>{'Authorization': 'Bearer ' + accessToken!},
        ),
      );
      print(response.data);

      print(response.statusCode);

      if (response.data["status"] == true) {
        print(response.data);
        String imageResponse = response.data["data"]["id"];
        // ImageResponseModel.fromJson(response.data);

        print(" this is image response haaah$imageResponse");
        return imageResponse;
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
