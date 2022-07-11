import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/domain/entities/SalesData.dart';
import 'package:salesforce/domain/usecases/hiveUseCases/hiveUseCases.dart';
import 'package:salesforce/injectable.dart';
import 'package:uuid/uuid.dart';
import '../../../domain/entities/requestDeliver.dart';
import '../../../error/exception.dart';
import '../../../utils/AapiUtils.dart';
import '../../../utils/apiUrl.dart';
import '../../models/SalesDataModel.dart';
import '../../models/merchandiseOrderModel.dart';
import '../../models/requestDeliveredModel.dart';

abstract class SalesDataRemoteSource {
  Future<String?> saveSalesData(List<SalesData> salesData);
  Future<String> saveDeliveredRequest(List<RequestDelivered> requestDelivered);
}

@Injectable(as: SalesDataRemoteSource)
class SalesDataRemoteSourceImpl implements SalesDataRemoteSource {
  var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();
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
    if (images.isNotEmpty) {
      var formImageData = FormData.fromMap({
        "image": images,
        'unique_key': uuids,
      });

      String? accessToken;
      AppInterceptors appInterceptors = AppInterceptors();
      accessToken = await appInterceptors.getUserAccessToken();
      try {
        Response response = await dio.post(
          ApiUrl.imageUpload,
          data: formImageData,
          options: Options(
            headers: <String, String>{
              'Content-Type': 'multipart/form-data',
              'Authorization': 'Bearer ' + accessToken!
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
      return "Success";
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
      var salesDataModeljson = salesDataModel.map((e) => e.toJson(e)).toList();
      var encodedSalesData = json.encode(salesDataModeljson);
      String? accessToken;
      AppInterceptors appInterceptors = AppInterceptors();
      accessToken = await appInterceptors.getUserAccessToken();
      try {
        Response response = await dio.post(
          ApiUrl.salesData,
          data: encodedSalesData,
          options: Options(
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ' + accessToken!
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
    } else {}
  }

  @override
  Future<String> saveDeliveredRequest(
      List<RequestDelivered> requestDelivered) async {
    List<RequestedDeliveredModel> requestDeliveredModelList = [];
    for (RequestDelivered request in requestDelivered) {
      RequestedDeliveredModel requestDeliveredModel =
          RequestedDeliveredModel(request.id, request.deliveredDate);
      requestDeliveredModelList.add(requestDeliveredModel);
    }
    var inJson = requestDeliveredModelList.map((e) => e.toJson()).toList();
    var jsonDecoded = json.encode(inJson);

    Dio dio = Dio();
    String? accessToken;
    AppInterceptors appInterceptors = AppInterceptors();
    accessToken = await appInterceptors.getUserAccessToken();

    try {
      Response response = await dio.post(
        ApiUrl.requestDelivered,
        data: jsonDecoded,
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ' + accessToken!
          },
        ),
      );

      if (response.statusCode == 200) {
        return "Success";
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
