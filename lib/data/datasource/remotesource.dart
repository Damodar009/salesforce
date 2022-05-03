import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/data/datasource/hive.dart';
import 'package:salesforce/domain/entities/userData.dart';
import 'package:salesforce/utils/apiUrl.dart';
import 'package:salesforce/utils/hiveConstant.dart';
import '../../error/exception.dart';
import '../models/Userdata.dart';

abstract class RemoteSource {
  Future<UserData> login(String username, String password);
  Future<String> changePassword(String oldpassword, String newPassword);
  Future<String> postImage();
  Future<String> getProductList();
  Future<String> getRegionList();
  Future<String> attendenceSave();
  Future<String?> postDataToApi();
}

@Injectable(as: RemoteSource)
class RemoteSourceImplementation implements RemoteSource {
  Dio dio = Dio();
  SaveLocally hive = SaveLocally();

  RemoteSourceImplementation();

  @override
  Future<UserData> login(String username, String password) async {
    const String _clientId = 'clientId';
    const String _clientSecret = 'secret';
    try {
      Response response = await dio.post(
        ApiUrl.login,
        data: <String, String>{
          'grant_type': 'password',
          'username': username,
          'password': password,
        },
        options: Options(
          contentType: "application/x-www-form-urlencoded",
          headers: <String, String>{
            'Authorization': 'Basic ' +
                base64Encode(utf8.encode('$_clientId:$_clientSecret'))
          },
        ),
      );
      if (response.statusCode == 200) {
        UserData userData = UserDataModel.fromJson(response.data);
        print(userData.userid);

        hive.savetoken(userdata: userData);
        print('oleoleoleoleoleoeloel');

        return userData;
      } else {
        throw ServerException();
      }
    } on DioError {
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
    // dio.options.headers['content-Type'] = 'application/json';

    Box box = await hive.openBox(HiveConstants.userdata);
    print('.box('')');

    String acessToken = box.get('access_token');
    // String userId = box.get('userid');
    
    print(box.keys);
    // print(userId);
    // try {
    Response response = await dio.post(
      ApiUrl.changePassword,
      data: <String, String>{
        // 'userId': userId,
        'oldPassword': oldpassword,
        'newPassword': newPassword,
      },
      options: Options(
        contentType: "application/x-www-form-urlencoded",
        headers: <String, String>{'Authorization': 'Bearer ' },
      ),
    );
    print(ApiUrl.changePassword);
    print(oldpassword + newPassword);
    print(response.statusCode);
    if (response.data["status"] == true) {
      return Future.value('Success');
    } else {
      print('server dfshajkdhfjkdshfjk');
      throw ServerException();
    }
    // }
    //  on DioError catch (e) {
    //   throw ServerException();
    // }
  }

//todo
  @override
  Future<String> postImage() async {
    try {
      Response response = await dio.post(
        ApiUrl.login,
        data: <String, String>{'grant_type': 'password'},
        options: Options(
          contentType: "application/x-www-form-urlencoded",
          headers: <String, String>{'Authorization': 'Basic '},
        ),
      );
      if (response.data["status"] == true) {
        return Future.value('Success');
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<String> attendenceSave() {
    // TODO: implement attendenceSave
    throw UnimplementedError();
  }

  @override
  Future<String> getProductList() {
    // TODO: implement getProductList
    throw UnimplementedError();
  }

  @override
  Future<String> getRegionList() {
    // TODO: implement getRegionList
    throw UnimplementedError();
  }
}
