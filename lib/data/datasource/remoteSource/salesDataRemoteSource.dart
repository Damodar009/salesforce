import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/data/models/merchandiseOrderModel.dart';
import 'package:salesforce/domain/entities/SalesData.dart';
import '../../../error/exception.dart';

import '../../../utils/apiUrl.dart';
import '../../models/SalesDataModel.dart';
import 'package:uuid/uuid.dart';

abstract class SalesDataRemoteSource {
  Future<String?> saveSalesData(List<SalesDataModel> salesData);
}

@Injectable(as: SalesDataRemoteSource)
class SalesDataRemoteSourceImpl implements SalesDataRemoteSource {
  Future<String?> postImage(List<SalesData> salesData,
      List<String?> paymentDocuments, List<String?> merchandiseType) async {
    Dio dio = Dio();
    Uuid uuid = const Uuid();

    List<dynamic> images = [];
    List<String> uuids = [];

    for (var i = 0; i < salesData.length; i++) {
      if (salesData[i].paymentdocument != null) {
        var paymentDocument =
            await MultipartFile.fromFile(salesData[i].paymentdocument!);
        images.add(paymentDocument);
        String v4 = uuid.v4();
        uuids.add(v4);
        paymentDocuments.add(v4);
      } else {
        paymentDocuments.add(null);
      }

      if (salesData[i].merchandiseOrderPojo != null) {
        var merchandiseImage = await MultipartFile.fromFile(
            salesData[i].merchandiseOrderPojo!.image);
        images.add(merchandiseImage);
        String v4 = uuid.v4();
        uuids.add(v4);
        merchandiseType.add(v4);
      } else {
        merchandiseType.add(null);
      }
    }

    /// post images
    var formImageData = FormData.fromMap({
      "image": images,
      'unique_key': uuids,
    });

    try {
      //todo image
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
  Future<String?> saveSalesData(List<SalesDataModel> salesData) async {
    Dio dio = Dio();
    List<String?> paymentDocuments = [];
    List<String?> merchandiseType = [];
    List<SalesDataModel> salesDataMOdel = [];

    String? success =
        await postImage(salesData, paymentDocuments, merchandiseType);
    if (success == "Success") {
      List<SalesDataModel> salesDataModel = [];
      for (var i = 0; i < salesData.length; i++) {
        String? payment = paymentDocuments[i];
        MerchandiseOrderModel? merchandiseOrderModel;
        if (salesData[i].merchandiseOrderPojo != null) {
          merchandiseOrderModel = MerchandiseOrderModel(
              merchandise_id: salesData[i].merchandiseOrderPojo!.merchandise_id,
              description: salesData[i].merchandiseOrderPojo!.description,
              image: merchandiseType[i]!);
        }

        SalesDataModel salesModel = SalesDataModel(
          salesPojo: salesData[i].sales,
          availabilityPojo: salesData[i].availability,
          returnsPojo: salesData[i].returns,
          salesDescription: salesData[i].salesDescription,
          returnedDescription: salesData[i].returnedDescription,
          availabilityDescription: salesData[i].availabilityDescription,
          assignedDepot: salesData[i].assignedDepot,
          collectionDate: salesData[i].collectionDate,
          latitude: salesData[i].latitude,
          longitude: salesData[i].longitude,
          retailer: salesData[i].retailer,
          paymentType: salesData[i].paymentType,
          paymentdocument: payment,
          retailerPojo: salesData[i].retailerPojo,
          userId: salesData[i].userId,
          merchandiseOrderPojo: merchandiseOrderModel,
        );

        salesDataModel.add(salesModel);
      }

      var salesDataModeljson = salesDataMOdel.map((e) => {e.toJson(e)}).toList;

      var jsonEncoded = json.encode(salesDataModeljson);
      try {
        Response response = await dio.post(
          ApiUrl.salesData,
          data: jsonEncoded,
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
    } else {
      //todo
      print("image saving failed");
    }
  }
}
