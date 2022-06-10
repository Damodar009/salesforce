import 'dart:io';

import 'package:internet_connection_checker/internet_connection_checker.dart';

class Network {
  Future<bool> checkInternetConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;

    if (result == true) {
      return true;
    } else {
      return false;
    }
  }
}
