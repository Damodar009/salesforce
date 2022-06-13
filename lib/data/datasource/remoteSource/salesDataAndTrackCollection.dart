import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/domain/entities/saleslocationTrack.dart';
import 'package:salesforce/domain/usecases/hiveUseCases/hiveUseCases.dart';
import 'package:salesforce/injectable.dart';
import 'package:salesforce/utils/hiveConstant.dart';
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
  var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();
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

    var salesTrackInJson = salesLocationTrackModelList
        .map((salesLocationTrackModel) => salesLocationTrackModel.toJson())
        .toList();

    var jsonEncodedAnswer = jsonEncode(salesTrackInJson);
    print("this is list of sales data colletion");

    String? accessToken;

    Box box = await Hive.openBox(HiveConstants.userdata);

    var accessTokenSuccessOrFailed =
        useCaseForHiveImpl.getValueByKey(box, "access_token");
    accessTokenSuccessOrFailed.fold((l) => {print("failed")},
        (r) => {accessToken = r!, print(r.toString())});

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
