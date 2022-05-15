import 'package:hive/hive.dart';
import 'package:salesforce/domain/entities/userData.dart';
import 'package:salesforce/domain/entities/userDetailsData.dart';
import 'package:salesforce/utils/hiveConstant.dart';

class SaveLocally {
  Future<Box> openBox() async {
    Box box = await Hive.openBox(HiveConstants.userdata);
    return box;
  }

  Future savetoken(
      {UserData? userdata, UserDetailsData? userDetailsData}) async {
    try {
      var box = await openBox();

      await box.put("refresh_token", userdata?.refresh_token);
      await box.put("access_token", userdata?.access_token);
      await box.put("userid", userdata?.userid);
      //  await box.put("userid", userdata.userid);
      await box.put("name", userdata?.name);
      await box.put("expires_in", userdata?.expires_in);
      await box.put("userdata", userdata?.role);
      await box.put("token_type", userdata?.token_type);
      await box.put("scope", userdata?.scope);
      await box.put("RoleId", userDetailsData?.roleId);
      await box.put("RoleName", userDetailsData?.roleName);
      await box.put(
          "userDetailId", userDetailsData?.userDetail!.user_detail_id);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future deletetoken() async {
    try {
      var box = await openBox();

      await box.deleteFromDisk();
    } catch (e) {
      return false;
    }
  }

  Future showtoken() async {
    try {
      var box = await openBox();

      if (box.isEmpty) {
        print('box.isEmpty)');
      } else if (box.isNotEmpty) {
        print('box is not empty');
      } else {
        print('idk');
      }
    } catch (e) {
      return false;
    }
  }
}
