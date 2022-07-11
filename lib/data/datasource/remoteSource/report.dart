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
    //  var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();
    Dio dio = Dio();
    @override
    String? accessToken;
    AppInterceptors appInterceptors = AppInterceptors();
    accessToken = await appInterceptors.getUserAccessToken();

    try {
      Response response = await dio.post(
        ApiUrl.report,
        data: {"order_type": "sales", "product_id": "0", "time": "DAY"},
        options: Options(
          contentType: "application/json",
          headers: <String, String>{'Authorization': 'Bearer $accessToken'},
        ),
      );
      if (response.data["status"] == true) {
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
