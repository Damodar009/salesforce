import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/data/models/image_response_model.dart';
import 'package:salesforce/domain/entities/image.dart';
import 'package:salesforce/error/exception.dart';
import 'package:salesforce/utils/apiUrl.dart';

abstract class UploadImageRemoteDataSource {
  Future<ImageResponse> uploadImageSave(String imageName);
}

@Injectable(as: UploadImageRemoteDataSource)
class UploadImageRemoteDataSourceImpl implements UploadImageRemoteDataSource {
  Dio dio = Dio();
  String image = "";

  @override
  Future<ImageResponse> uploadImageSave(String imageName) async {
    try {
      print("upload image repo");
      print(ApiUrl.imageUpload);

      print("image :$imageName");

      String fileName = imageName.split('/').last;

      FormData data = FormData.fromMap({
        "file": await MultipartFile.fromFile(imageName, filename: fileName),
      });
      Response response = await dio.post(
        ApiUrl.imageUpload,
        data: data,
        options: Options(
          contentType: "multipart/form-data",
          headers: <String, String>{
            'Authorization': 'Bearer bb81196a-bc85-4c26-b3af-abae634a3795'
          },
        ),
      );
      print(response.data);

      print(response.statusCode);

      if (response.data["status"] == true) {
        print(response.data);
        ImageResponse imageResponse =
            ImageResponseModel.fromJson(response.data);
        print(imageResponse);
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
