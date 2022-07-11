import 'package:shared_preferences/shared_preferences.dart';

class DataChecker {
  setLocalDataChecker(bool isThereLocalData) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("isThereLocalData", isThereLocalData);
  }

  Future<bool?> getLocalDataChecker() async {
    final prefs = await SharedPreferences.getInstance();
    bool? isThereLocalData = prefs.getBool("isThereLocalData");
    return isThereLocalData;
  }

  setInitialFlag(bool flag) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("initialFlag", flag);
  }

  Future<bool?> getInitialFlag() async {
    final prefs = await SharedPreferences.getInstance();
    bool? isThereLocalData = prefs.getBool("initialFlag");
    return isThereLocalData;
  }
}
