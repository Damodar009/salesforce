// import 'dart:convert';

import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:salesforce/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:salesforce/data/models/Userdata.dart';
import 'package:salesforce/domain/entities/userData.dart';
import 'package:salesforce/error/exception.dart';
import 'package:salesforce/utils/hiveConstant.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SignInLocalDataSource {
  Future<void> saveUserDataToLocal(UserDataModel user);
  Future<UserDataModel?> getUserDataFromLocal();
}

@Injectable(as: SignInLocalDataSource)
class SignInLocalDataSourceImpl extends SignInLocalDataSource {
  @override
  Future<UserDataModel?> getUserDataFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    String? userInfo = prefs.getString(HiveConstants.userdata);
    if (userInfo != null) {
      UserDataModel userInfoDecoded =
          UserDataModel.fromJson(jsonDecode(userInfo) as Map<String, dynamic>);
      return userInfoDecoded;
    }
    return null;
  }

  @override
  Future<void> saveUserDataToLocal(UserDataModel? user) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      if (user != null) {
        await prefs.setString(
            HiveConstants.userdata, jsonEncode(user.toJson()));

        ;
      }
    } catch (e) {
      throw CacheException();
    }
  }
}
