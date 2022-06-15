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

@module
abstract class InjectionModule {
//injecting third party libraries
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}

abstract class SignInLocalDataSource {
  Future<void> saveUserDataToLocal(UserDataModel user);
  Future<UserDataModel?> getUserDataFromLocal();
}

@Injectable(as: SignInLocalDataSource)
class SignInLocalDataSourceImpl extends SignInLocalDataSource {
  final prefs = getIt<SharedPreferences>();

  @override
  Future<UserDataModel?> getUserDataFromLocal() async {
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

  setLocalDataChecker(bool isThereLocalData) {
    prefs.setBool("isThereLocalData", isThereLocalData);
  }

  bool? getLocalDataChecker() {
    bool? isThereLocalData = prefs.getBool("isThereLocalData");
    return isThereLocalData;
  }

  setInitialFlag(bool flag) {
    prefs.setBool("initialFlag", flag);
  }

  bool? getInitialFlag() {
    bool? isThereLocalData = prefs.getBool("initialFlag");
    return isThereLocalData;
  }
}
