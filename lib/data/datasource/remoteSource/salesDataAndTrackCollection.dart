import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/domain/entities/saleslocationTrack.dart';
import 'package:salesforce/domain/usecases/hiveUseCases/hiveUseCases.dart';
import 'package:salesforce/injectable.dart';
import '../../../error/exception.dart';
import '../../../utils/AapiUtils.dart';
import '../../../utils/apiUrl.dart';
import '../../models/SalesLocationTrackModel.dart';

abstract class SalesDataAndTrackCollectionRemoteSource {
  Future<List<SalesLocationTrack>> saveSalesDataAndTrackCollection(
      List<SalesLocationTrack> listSalesLocationTrack);
}

@Injectable(as: SalesDataAndTrackCollectionRemoteSource)
class SalesDataAndTrackCollectionRemoteSourceimpl
    implements SalesDataAndTrackCollectionRemoteSource {
  @override
  Future<List<SalesLocationTrack>> saveSalesDataAndTrackCollection(
      List<SalesLocationTrack> listSalesLocationTrack) async {
    Dio dio = Dio();
    List<SalesLocationTrackModel> salesLocationTrackModelList = [];

    for (var i = 0; i < listSalesLocationTrack.length; i++) {
      var salesLocationTRack = listSalesLocationTrack[i];
      SalesLocationTrackModel salesLocationTrackModel = SalesLocationTrackModel(
          trackingDate: salesLocationTRack.trackingDate,
          latitude: salesLocationTRack.latitude,
          userId: salesLocationTRack.userId,
          longitude: salesLocationTRack.longitude);
      salesLocationTrackModelList.add(salesLocationTrackModel);
    }
    var salesTrackInJson = salesLocationTrackModelList
        .map((salesLocationTrackModel) => salesLocationTrackModel.toJson())
        .toList();

    var jsonEncodedAnswer = jsonEncode(salesTrackInJson);
    String? accessToken;
    AppInterceptors appInterceptors = AppInterceptors();
    accessToken = await appInterceptors.getUserAccessToken();
    try {
      Response response = await dio.post(
        ApiUrl.saveSalesCollectionTracking,
        data: jsonEncodedAnswer,
        options: Options(
          contentType: "application/json",
          headers: <String, String>{'Authorization': 'Bearer ' + accessToken!},
        ),
      );
      if (response.data["status"] == true) {
        List<SalesLocationTrack> salesLocationTrack =
            (response.data["data"] as List).map((salesLocationTrack) {
          return SalesLocationTrackModel.fromJson(salesLocationTrack);
        }).toList();

        return salesLocationTrack;
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
