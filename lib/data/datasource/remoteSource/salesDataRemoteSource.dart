// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import '../../../error/exception.dart';
// import '../../../error/failure.dart';
// import '../../../utils/apiUrl.dart';
// import '../../models/SalesDataModel.dart';

// abstract class SalesDataRemoteSource {
//   Future<String> saveSalesData(SalesDataModel salesData);
// }

// class SalesDataRemoteSourceImpl implements SalesDataRemoteSource {
//   @override
//   Future<String> saveSalesData(SalesDataModel salesData) async {
//     Dio dio = Dio();
//     try {
//       Response response = await dio.post(
//         ApiUrl.salesData,
//         data: jsonEncodedAnswer,
//         options: Options(
//           contentType: "application/json",
//           headers: <String, String>{
//             'Authorization': 'Bearer 6c737f4e-45a1-4938-b559-4ee60f403dcc'
//           },
//         ),
//       );
//       if (response.data["status"] == true) {
//         List<SalesLocationTrack> salesLocationTrack =
//             (response.data["data"] as List).map((salesLoctionTrack) {
//           return SalesLocationTrackModel.fromJson(salesLoctionTrack);
//         }).toList();
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:salesforce/domain/entities/SalesData.dart';
import '../../../error/exception.dart';

import '../../../utils/apiUrl.dart';
import '../../models/SalesDataModel.dart';
import 'package:uuid/uuid.dart';

abstract class SalesDataRemoteSource {
  Future<String> saveSalesData(
      List<SalesDataModel> salesData, List<String> uuids);
  Future<String> postImage(List<SalesData> salesData);
}

class SalesDataRemoteSourceImpl implements SalesDataRemoteSource {
  @override
  Future<String> postImage(List<SalesData> salesData) async {
    Dio dio = Dio();
    Uuid uuid = Uuid();

    List<dynamic> images = [];
    List<String> uuids = [];
    for (var i = 0; i < salesData.length; i++) {
      var fromFile =
          await MultipartFile.fromFile(salesData[i].paymentdocument!);
      images.add(fromFile);
      String v4 = uuid.v4();
      uuids.add(v4);
    }

    /// post images
    var formImageData = FormData.fromMap({
      "image": images,
      'unique_key': uuids,
    });

    try {
      Response response = await dio.post(
        ApiUrl.salesData,
        data: formImageData,
        options: Options(
          headers: <String, String>{
            'Accept': 'application/json',
            'Content-Type': 'multipart/form-data',
            'Authorization': 'Bearer 4ff45a34-268d-44e0-9f04-6dc95acd4044'
          },
        ),
      );
      if (response.data["status"] == true) {
        return "Success";
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<String> saveSalesData(
      List<SalesDataModel> salesData, List<String> uuids) {
    // TODO: implement saveSalesData
    throw UnimplementedError();
  }

  // @override
//  Future<String> saveSalesData(
  //   List<SalesData> salesData, List<String> uuids) async {
  // Dio dio = Dio();
  // List<SalesDataModel> salesDataModelList = [];
  // for (var i = 0; i < salesData.length; i++) {
  //   SalesData saleData = salesData[i];
  //   SalesDataModel salesDataModel = SalesDataModel(
  //       sales: saleData.sales,
  //       availability: saleData.availability,
  //       returns: saleData.returns,
  //       salesDescription: saleData.salesDescription,
  //       returnedDescription: saleData.returnedDescription,
  //       stockDescription: saleData.stockDescription,
  //       availabilityDescription: saleData.availabilityDescription,
  //       assignedDepot: saleData.assignedDepot,
  //       collectionDate: saleData.collectionDate,
  //       latitude: saleData.latitude,
  //       longitude: saleData.longitude,
  //       paymentType: saleData.paymentType,
  //       paymentdocument: uuids[i],
  //       userId: saleData.userId,
  //       retiler: saleData.retiler);
  //
  //   salesDataModelList.add(salesDataModel);
  // }
  //
  // var salesTrackInJson = salesDataModelList
  //     .map((salesLocationTrackModel) => salesLocationTrackModel.toJson())
  //     .toList();
  //
  // var jsonEncodedAnswer = jsonEncode(salesTrackInJson);
  //
  // try {
  //   Response response = await dio.post(
  //     ApiUrl.salesData,
  //     data: jsonEncodedAnswer,
  //     options: Options(
  //       headers: <String, String>{
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer 4ff45a34-268d-44e0-9f04-6dc95acd4044'
  //       },
  //     ),
  //   );
  //   if (response.data["status"] == true) {
  //     // List<SalesLocationTrack> salesLocationTrack =
  //     //     (response.data["data"] as List).map((salesLoctionTrack) {
  //     //   return SalesLocationTrackModel.fromJson(salesLoctionTrack);
  //     // }).toList();
  //
  //     print('oleoleoleoleoleoeloel');
  //
  //     return "gf";
  //   } else {
  //     throw ServerException();
  //   }
  // } on DioError catch (e) {
  //   print(e);
  //   throw ServerException();
  // }
  //}
}
      
