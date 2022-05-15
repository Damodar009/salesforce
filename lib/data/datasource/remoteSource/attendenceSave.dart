import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/data/models/AttendenceModel.dart';
import 'package:salesforce/domain/entities/attendence.dart';

import '../../../error/exception.dart';
import '../../../utils/apiUrl.dart';

abstract class AttendenceRemoteSource {
  Future<Attendence> saveAttendence(Attendence attendence);
}

@Injectable(as: AttendenceRemoteSource)
class AttendenceSave implements AttendenceRemoteSource {
  Dio dio = Dio();
  @override
  Future<Attendence> saveAttendence(Attendence attendence) async {
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

    var attendenceInJson = attendenceModel.toJson();
    var jsonEncodedAnswer = jsonEncode(attendenceInJson);

    try {
      Response response = await dio.post(
        ApiUrl.saveAttendence,
        data: jsonEncodedAnswer,
        options: Options(
          contentType: "application/json",
          headers: <String, String>{
            'Authorization': 'Bearer abfb62c1-fbf7-4da5-98d0-04ff5e4f899d'
          },
        ),
      );
      if (response.data["status"] == true) {
        Attendence attendence = AttendenceModel.fromJson(response.data["data"]);

        print('oleoleoleoleoleoeloel');

        return attendence;
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
