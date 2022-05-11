import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../error/exception.dart';
import '../../../error/failure.dart';
import '../../../utils/apiUrl.dart';
import '../../models/SalesDataModel.dart';

abstract class SalesDataRemoteSource {
  Future<String> saveSalesData(SalesDataModel salesData);
}

class SalesDataRemoteSourceImpl implements SalesDataRemoteSource {
  @override
  Future<String> saveSalesData(SalesDataModel salesData) async {
    Dio dio = Dio();
    try {
      Response response = await dio.post(
        ApiUrl.salesData,
        data: jsonEncodedAnswer,
        options: Options(
          contentType: "application/json",
          headers: <String, String>{
            'Authorization': 'Bearer 6c737f4e-45a1-4938-b559-4ee60f403dcc'
          },
        ),
      );
      if (response.data["status"] == true) {
        List<SalesLocationTrack> salesLocationTrack =
            (response.data["data"] as List).map((salesLoctionTrack) {
          return SalesLocationTrackModel.fromJson(salesLoctionTrack);
        }).toList();

        print('oleoleoleoleoleoeloel');

        return "gf";
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
