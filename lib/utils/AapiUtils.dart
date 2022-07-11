import 'package:dio/dio.dart';

import '../data/datasource/local_data_sources.dart';

import '../injectable.dart';

class AppInterceptors extends Interceptor {
  final signInLocalDataSource = getIt<SignInLocalDataSource>();

  Future<String?> getUserAccessToken() async {
    var userDataModel = await signInLocalDataSource.getUserDataFromLocal();
    return userDataModel!.access_token;
  }

  Future<String?> getUserId() async {
    var userDataModel = await signInLocalDataSource.getUserDataFromLocal();
    return userDataModel!.userid;
  }
  // @override
  // FutureOr<dynamic> onRequest(RequestOptions options) async {
  //   if (options.headers.containsKey("requiresToken")) {
  //     //remove the auxiliary header
  //     options.headers.remove("requiresToken");
  //
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     var header = prefs.get("Header");
  //
  //     options.headers.addAll({"Header": "$header${DateTime.now()}"});
  //
  //     return options;
  //   }
  // }
  //
  // @override
  // FutureOr<dynamic> onError(DioError dioError) {
  //   if (dioError.message.contains("ERROR_001")) {
  //     // this will push a new route and remove all the routes that were present
  //     navigatorKey.currentState
  //         .pushNamedAndRemoveUntil("/login", (Route<dynamic> route) => false);
  //   }
  //
  //   return dioError;
  // }
  //
  // @override
  // FutureOr<dynamic> onResponse(Response options) async {
  //   if (options.headers.value("verifyToken") != null) {
  //     //if the header is present, then compare it with the Shared Prefs key
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     var verifyToken = prefs.get("VerifyToken");
  //
  //     // if the value is the same as the header, continue with the request
  //     if (options.headers.value("verifyToken") == verifyToken) {
  //       return options;
  //     }
  //   }
  //
  //   return DioError(
  //       request: options.request, message: "User is no longer active");
  // }
}
