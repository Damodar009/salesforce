import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../error/exception.dart';
import '../../../utils/AapiUtils.dart';
import '../../../utils/apiUrl.dart';
import '../../models/reportModel.dart';

abstract class ReportRemoteSource {
  Future<List<ReportModel>?> getReport();
}

@Injectable(as: ReportRemoteSource)
class ReportRemoteSourceImpl implements ReportRemoteSource {
  @override
  Future<List<ReportModel>?> getReport() async {

    Dio dio = Dio();
    @override
    String? accessToken;
    ApiHelper appInterceptors = ApiHelper();
    accessToken = await appInterceptors.getUserAccessToken();

    try {
      Response response = await dio.post(
        ApiUrl.report,
        data: {"order_type": "sales", "product_id": "0", "time": "DAY"},
        options: Options(
          contentType: "application/json",
          headers: <String, String>{'Authorization': 'Bearer eb8620bd-5337-45d4-a430-1285a4d7ec1c'},
        ),
      );
      if (response.data["status"] == true) {
        print(response);
        List<ReportModel> reports = (response.data["data"] as List)
            .map((report) => ReportModel.fromJson(report))
            .toList();
        print(response.data["data"]);
        return reports;
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      print(e);
    }
    throw ServerException();
  }
}
