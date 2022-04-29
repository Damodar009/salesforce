import 'package:hive/hive.dart';

class SaveLocally {
  Future<Box> openBox() async {
    Box box = await Hive.openBox('user_token');
    return box;
  }

  Future savetoken(
      {required String access_token, required String refresh_token}) async {
    try {
      var box = await openBox();

      await box.put("refresh_token", refresh_token);
      await box.put("acess_token", access_token);
      print('I am inside hive savetoken');
      print(box.values);

      print(box.values.toString() + 'whats in hive box');
      return true;
    } catch (e) {
      return false;
    }
  }
}
