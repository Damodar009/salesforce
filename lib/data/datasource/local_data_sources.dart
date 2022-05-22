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
  // final SharedPreferences preferences;

  // SignInLocalDataSourceImpl({required this.preferences});

  final prefs = getIt<SharedPreferences>();

  @override
  Future<UserDataModel?> getUserDataFromLocal() async {
    print("SharedPreferences you are not null hai");

    String? userInfo = prefs.getString(HiveConstants.userdata);
    if (userInfo != null) {
      UserDataModel userInfoDecoded =
          UserDataModel.fromJson(jsonDecode(userInfo) as Map<String, dynamic>);

      print("SharedPreferences you are not null hai");

      print(userInfoDecoded.access_token);

      return userInfoDecoded;
    }

    return null;
  }

  @override
  Future<void> saveUserDataToLocal(UserDataModel? user) async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();

    print("helo helo helo");
    try {
      print("saveUserDataToLocal");
      if (user != null) {
        print("user data is not null");
        await prefs.setString(
            HiveConstants.userdata, jsonEncode(user.toJson()));

        final Map<String, dynamic>? keys =
            jsonDecode(prefs.getString(HiveConstants.userdata)!)
                as Map<String, dynamic>;

        print("The below is the keys heppeno");

        print(keys!["access_token"]);
      }
    } catch (e) {
      throw CacheException();
    }
  }
}
