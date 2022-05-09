import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/domain/entities/saleslocationTrack.dart';
import '../../../error/exception.dart';
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
          salesLocationTRack.latitude,
          salesLocationTRack.longitude,
          salesLocationTRack.trackingDate,
          salesLocationTRack.userId);
      salesLocationTrackModelList.add(salesLocationTrackModel);
    }

    print("this is list of sales dara colletion");
    print(salesLocationTrackModelList);

    var salesTrackInJson = salesLocationTrackModelList
        .map((salesLocationTrackModel) => salesLocationTrackModel.toJson())
        .toList();

    var jsonEncodedAnswer = jsonEncode(salesTrackInJson);
    print("this is list of sales data colletion");
    print(jsonEncodedAnswer);

    try {
      Response response = await dio.post(
        ApiUrl.saveSalesCollectionTracking,
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
