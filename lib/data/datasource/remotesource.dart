import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import 'package:injectable/injectable.dart';
import 'package:salesforce/data/datasource/hive.dart';
import 'package:salesforce/domain/entities/userData.dart';
import 'package:salesforce/utils/apiUrl.dart';
import '../../error/exception.dart';
import '../models/Userdata.dart';

abstract class RemoteSource {
  Future<UserData> login(String username, String password);
  Future<String> changePassword(String oldpassword, String newPassword);
  Future<UserData> resetPassword();
  Future<String?> postDataToApi();
}

@Singleton(as: RemoteSource)
class RemoteSourceImplementation implements RemoteSource {
  Dio dio = Dio();
  SaveLocally hive = SaveLocally();

  RemoteSourceImplementation();
  // getIt.get<>().login(event.username, event.password);

  @override
  Future<UserData> login(String username, String password) async {
    dio.options.headers['content-Type'] = 'application/json';
    // dio.options.headers["Authorization"] =
    //     "Bearer " + userdata.read('access_token');

    try {
      Response response = await dio.post(
        ApiUrl.login,
        data: <String, String>{
          'username': username,
          'password': password,
          'grant_type': 'password'
        },
        options: Options(
          contentType: "application/x-www-form-urlencoded",
          headers: <String, String>{
            'Authorization': 'Basic Y2xpZW50SWQ6c2VjcmV0'
          },
        ),
      );
      if (response.statusCode == 200) {
        UserData userData = UserDataModel.fromJson(response.data);

        hive.savetoken(
            access_token: userData.access_token,
            refresh_token: userData.refresh_token);

        return userData;
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<String?> postDataToApi() {
    // TODO: implement postSurveyAnswer
    throw UnimplementedError();
  }

  @override
  Future<String> changePassword(String oldpassword, String newPassword) async {
    dio.options.headers['content-Type'] = 'application/json';

    Box box = await hive.openBox();

    String acessToken = box.get('acess_token');
    // dio.options.headers["Authorization"] =
    //     "Bearer " + userdata.read('access_token');

    // try {
      Response response = await dio.post(
        ApiUrl.login,
        data: <String, String>{
          'oldPassword': oldpassword,
          'newPassword': newPassword,
          'grant_type': 'password'
        },
        options: Options(
          contentType: "application/x-www-form-urlencoded",
          headers: <String, String>{'Authorization': 'Basic ' + acessToken},
        ),
      );

      print(response.statusCode);

      if (response.data["status"] == true) {
        return Future.value('Success');
      } else {
        throw ServerException();
      }
    // } on DioError catch (e) {
    //   throw ServerException();
    // }
  }

  @override
  Future<UserData> resetPassword() async {
    throw UnimplementedError();

    // Box box = await SaveLocally().openBox();
    //     if (box.isNotEmpty) {
    //       print('hellhhhhhhhho');
    //       String token = box.get('token');
    //       print(token);
    // List<ProductModel> searchList =
    //     await SearchRepo().searchProduct(token: token, name: event.name);

    // print(searchList);

    // emit(SeachProductState(searchList: searchList));
    // }
  }
}
