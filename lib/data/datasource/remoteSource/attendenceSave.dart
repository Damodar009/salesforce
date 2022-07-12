import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/data/models/AttendenceModel.dart';
import 'package:salesforce/domain/entities/attendence.dart';
import 'package:salesforce/domain/usecases/hiveUseCases/hiveUseCases.dart';
import 'package:salesforce/injectable.dart';
import '../../../domain/entities/AttendendenceDashbard.dart';
import '../../../error/exception.dart';
import '../../../utils/AapiUtils.dart';
import '../../../utils/apiUrl.dart';
import '../../models/AttendenceDashBoardModel.dart';

abstract class AttendenceRemoteSource {
  Future<Attendence> saveAttendence(Attendence attendence);
  Future<AttendanceDashboard?> getDashBoardAttendance();
}

@Injectable(as: AttendenceRemoteSource)
class AttendenceSave implements AttendenceRemoteSource {
  var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();
  Dio dio = Dio();
  @override
  Future<Attendence> saveAttendence(Attendence attendence) async {
    print("this is inside save attendence");
    AttendenceModel attendenceModel = AttendenceModel(
        id: attendence.id,
        macAddress: attendence.macAddress,
        checkin: attendence.checkin,
        checkin_latitude: attendence.checkin_latitude,
        checkin_longitude: attendence.checkin_longitude,
        checkout: attendence.checkout,
        checkout_latitude: attendence.checkout_latitude,
        checkout_longitude: attendence.checkout_longitude,
        user: attendence.user);

    var attendanceInJson = attendenceModel.toJson();
    var jsonEncodedAnswer = jsonEncode(attendanceInJson);

    String? accessToken;
    ApiHelper appInterceptors = ApiHelper();
    accessToken = await appInterceptors.getUserAccessToken();

    try {
      Response response = await dio.post(
        ApiUrl.saveAttendence,
        data: jsonEncodedAnswer,
        options: Options(
          contentType: "application/json",
          headers: <String, String>{'Authorization': 'Bearer ' + accessToken!},
        ),
      );
      if (response.data["status"] == true) {
        Attendence attendance = AttendenceModel.fromJson(response.data["data"]);
        return attendance;
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      print(e);
    }
    throw ServerException();
  }

  @override
  Future<AttendanceDashboard?> getDashBoardAttendance() async {
    String? accessToken;
    ApiHelper appInterceptors = ApiHelper();
    accessToken = await appInterceptors.getUserAccessToken();

    try {
      Response response = await dio.get(
        ApiUrl.dashboardAttendance,
        options: Options(
          contentType: "application/json",
          headers: <String, String>{'Authorization': 'Bearer ' + accessToken!},
        ),
      );
      if (response.data["status"] == true) {
        AttendanceDashboardModel attendanceDashboard =
            AttendanceDashboardModel.fromJson(response.data["data"]);

        return attendanceDashboard;
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      print(e);
    }
  }
}
