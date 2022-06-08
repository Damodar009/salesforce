import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/domain/entities/SalesData.dart';
import 'package:uuid/uuid.dart';

import '../../../error/exception.dart';
import '../../../utils/apiUrl.dart';
import '../../models/SalesDataModel.dart';
import '../../models/merchandiseOrderModel.dart';

abstract class SalesDataRemoteSource {
  Future<String?> saveSalesData(List<SalesData> salesData);
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
    var formImageData = FormData.fromMap({
      "image": images,
      'unique_key': uuids,
    });

    try {
      //todo image
      Response response = await dio.post(
        "http://103.90.86.112:80/salesforce/api/image/multipleImageSave",
        data: formImageData,
        options: Options(
          headers: <String, String>{
            'Content-Type': 'multipart/form-data',
            'Authorization': 'Bearer 9d027860-ab49-4ff9-bb28-eb1b6618b661'
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
  Future<String?> saveSalesData(List<SalesData> salesData) async {
    Dio dio = Dio();
    List<String?> paymentDocuments = [];
    List<String?> merchandiseType = [];

    String? success =
        await postImage(salesData, paymentDocuments, merchandiseType);
    if (success == "Success") {
      print("starting sales data save");
      List<SalesDataModel> salesDataModel = [];
      for (var i = 0; i < salesData.length; i++) {
        String? payment = paymentDocuments[i];
        MerchandiseOrderModel? merchandiseOrderModel;
        if (salesData[i].merchandiseOrderPojo != null) {
          print("inside merchandise poijo");
          merchandiseOrderModel = MerchandiseOrderModel(
              merchandise_id: salesData[i].merchandiseOrderPojo!.merchandise_id,
              description: salesData[i].merchandiseOrderPojo!.description,
              image: merchandiseType[i]!);
        }
        print("the user id is ${salesData[i].assignedDepot}");
        print("the payment id is ${payment}");
        // todo check assigned depot

        SalesDataModel salesModel = SalesDataModel(
          salesPojo: salesData[i].sales,
          availabilityPojo: salesData[i].availability,
          returnsPojo: salesData[i].returns,
          salesDescription: salesData[i].salesDescription,
          returnedDescription: salesData[i].returnedDescription,
          availabilityDescription: salesData[i].availabilityDescription,
          assignedDepot: "NGBifEuwYylJoyRt7a8bkA==",
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
      var salesDataModeljson = salesDataModel.map((e) => e.toJson(e)).toList();
      var encodedSalesData = json.encode(salesDataModeljson);
      print(encodedSalesData);

      try {
        print("strating to send sales data ");
        Response response = await dio.post(
          ApiUrl.salesData,
          data: encodedSalesData,
          options: Options(
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Authorization': 'Bearer 9d027860-ab49-4ff9-bb28-eb1b6618b661'
            },
          ),
        );
        print(response);
        if (response.data["status"] == true) {
          print("sending sales data  is successful");
          return "Success";
        } else {
          print("failed to send sales data ");
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
