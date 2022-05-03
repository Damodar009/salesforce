import 'package:hive/hive.dart';
import 'package:salesforce/domain/entities/userData.dart';
import 'package:salesforce/utils/hiveConstant.dart';

class SaveLocally {
  Future<Box> openBox(String userdata) async {
    Box box = await Hive.openBox(HiveConstants.userdata);
    return box;
  }

  Future savetoken({required UserData userdata}) async {
    try {
      var box = await openBox(HiveConstants.userdata);

      await box.put("refresh_token", userdata.refresh_token);
      await box.put("access_token", userdata.access_token);
      await box.put("userid", userdata.userid);
      await box.put("name", userdata.name);
      await box.put("expires_in", userdata.expires_in);
      await box.put("userdata", userdata.role);
      await box.put("token_type", userdata.token_type);
      await box.put("scope", userdata.scope);

      return true;
    } catch (e) {
      return false;
    }
  }
}
