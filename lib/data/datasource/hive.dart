import 'package:hive/hive.dart';
import 'package:salesforce/domain/entities/userData.dart';
import 'package:salesforce/utils/hiveConstant.dart';

class SaveLocally {
  Future<Box> openBox() async {
    Box box = await Hive.openBox(HiveConstants.userdata);
    return box;
  }

  Future savetoken({required UserData userdata}) async {
    try {
      var box = await openBox();

      await box.put("refresh_token", userdata.refresh_token);
      await box.put("access_token", userdata.access_token);
      await box.put("access_token", userdata..userid);
      await box.put("access_token", userdata..name);
      await box.put("access_token", userdata.expires_in);
      await box.put("access_token", userdata.role);
      await box.put("access_token", userdata.token_type);
      await box.put("access_token", userdata.scope);

      return true;
    } catch (e) {
      return false;
    }
  }
}
