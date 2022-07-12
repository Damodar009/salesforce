import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/data/datasource/local_data_sources.dart';
import 'package:salesforce/data/models/SaveUserDetailsDataModel.dart';
import 'package:salesforce/data/models/leaveModel.dart';
import 'package:salesforce/data/models/userDetailsDataModel.dart';
import 'package:salesforce/domain/entities/Leave.dart';
import 'package:salesforce/domain/entities/retailerPojo.dart';
import 'package:salesforce/domain/entities/userDetailsData.dart';
import 'package:salesforce/utils/apiUrl.dart';
import '../../../domain/entities/depot.dart';
import '../../../domain/entities/depotProductRetailer.dart';
import '../../../domain/entities/merchandise.dart';
import '../../../domain/entities/paymentType.dart';
import '../../../domain/entities/products.dart';
import '../../../domain/entities/region.dart';
import '../../../domain/entities/requestedDropDown.dart';
import '../../../domain/entities/retailer.dart';
import '../../../domain/entities/retailerDropDown.dart';
import '../../../domain/entities/retailerType.dart';
import '../../../domain/usecases/hiveUseCases/hiveUseCases.dart';
import '../../../error/exception.dart';
import '../../../injectable.dart';
import '../../../utils/AapiUtils.dart';
import '../../models/DepotModel.dart';
import '../../models/Products.dart';
import '../../models/RetailerModel.dart';
import '../../models/RetailerType.dart';
import '../../models/Userdata.dart';
import '../../models/merchandiseModel.dart';
import '../../models/paymentTypeModel.dart';
import '../../models/regionModel.dart';
import '../../models/requestedDropDownModel.dart';
import '../../models/retailerDropDownModel.dart';
import '../../models/userDetailModel.dart';
import '../local_data_sources.dart';

abstract class RemoteSource {
  Future<UserDataModel> login(String username, String password);

  Future<String> changePassword(String oldpassword, String newPassword);
  Future<String> refreshToken();

  Future<DepotProductRetailer> getDepotProductAndRetailer();

  Future<UserDetailsData> getUserDetailsData();

  Future<List<RetailerPojo>> saveAllRetailer(List<Retailer> listOfRetailers);

  Future<SaveUserDetailsDataModel> saveUserDetails(
      SaveUserDetailsDataModel saveUserDetailsDataModel);
  Future<String> requestLeave(Leave leave);
  Future<bool> flagChecker();
}

@Injectable(as: RemoteSource)
class RemoteSourceImplementation implements RemoteSource {
  Dio dio = Dio();

  var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();
  final signInLocalDataSource = getIt<SignInLocalDataSource>();

  RemoteSourceImplementation();

  @override
  Future<UserDataModel> login(String username, String password) async {
    const String _clientId = 'clientId';
    const String _clientSecret = 'secret';

    try {
      Response response = await dio.post(
        ApiUrl.login,
        data: <String, String>{
          'grant_type': 'password',
          'username': username,
          'password': password,
        },
        options: Options(
          contentType: "application/x-www-form-urlencoded",
          headers: <String, String>{
            'Authorization': 'Basic ' +
                base64Encode(utf8.encode('$_clientId:$_clientSecret'))
          },
        ),
      );
      if (response.statusCode == 200) {
        UserDataModel userData = UserDataModel.fromJson(response.data);
        return userData;
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<UserDetailsData> getUserDetailsData() async {
    String? userId;
    String? accessToken;
    ApiHelper appInterceptors = ApiHelper();
    accessToken = await appInterceptors.getUserAccessToken();
    userId = await appInterceptors.getUserId();
    try {
      Response response = await dio.get(
        ApiUrl.getSalesStaff + userId!,
        options: Options(
          headers: <String, String>{'Authorization': 'Bearer ' + accessToken!},
        ),
      );

      if (response.data["status"] == true) {
        UserDetailsDataModel userDetailsData =
            UserDetailsDataModel.fromJson(response.data["data"]);
        return userDetailsData;
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<String> changePassword(String oldPassword, String newPassword) async {
    String? userId;
    String? accessToken;
    ApiHelper appInterceptors = ApiHelper();
    accessToken = await appInterceptors.getUserAccessToken();
    userId = await appInterceptors.getUserId();

    try {
      Response response = await dio.post(
        ApiUrl.changePassword,
        data: <String, String>{
          'oldPassword': oldPassword,
          'newPassword': newPassword,
          'userId': userId!
        },
        options: Options(
          headers: <String, String>{'Authorization': 'Bearer ' + accessToken!},
        ),
      );
      if (response.data["status"] == true) {
        return Future.value('Success');
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<DepotProductRetailer> getDepotProductAndRetailer() async {
    String? accessToken;
    ApiHelper appInterceptors = ApiHelper();
    accessToken = await appInterceptors.getUserAccessToken();

    try {
      Response response = await dio.get(
        ApiUrl.depotProductAndRetailor,
        options: Options(
          headers: <String, String>{'Authorization': 'Bearer ' + accessToken!},
        ),
      );

      if (response.data["status"] == true) {
        DepotProductRetailer depotProductRetailer;
        List<RetailerType> retailerTypes =
            (response.data["data"]["retailerTypeDropDown"] as List)
                .map((sectorModel) => RetailerTypeModel.fromJson(sectorModel))
                .toList();

        List<Products> products =
            (response.data["data"]["productDropDown"] as List)
                .map((sectorModel) => ProductsModel.fromJson(sectorModel))
                .toList();

        List<Depot> depots = (response.data["data"]["depotDetails"] as List)
            .map((sectorModel) => DepotModel.fromJson(sectorModel))
            .toList();

        List<RetailerDropDown> retailerDropdown = (response.data["data"]
                ["retailerDropDown"] as List)
            .map((sectorModel) => RetailerDropDownModel.fromJson(sectorModel))
            .toList();

        List<MerchandiseDropDown> merchandiseDropDown = (response.data["data"]
                ["merchandiseDropDown"] as List)
            .map(
                (sectorModel) => MerchandiseDropDownModel.fromJson(sectorModel))
            .toList();

        List<RegionDropDown> regionDropDown =
            (response.data["data"]["regionDropDown"] as List)
                .map((sectorModel) => RegionDropDownModel.fromJson(sectorModel))
                .toList();

        List<RequestedDropDown> requestedDropDown = (response.data["data"]
                ["requestedDropDown"] as List)
            .map((sectorModel) => RequestedDropDownModel.fromJson(sectorModel))
            .toList();

        List<PaymentType> paymentType =
            (response.data["data"]["paymentType"] as List)
                .map((paymentType) => PaymentTypeModel.fromJson(paymentType))
                .toList();

        depotProductRetailer = DepotProductRetailer(
            products: products,
            retailerType: retailerTypes,
            depots: depots,
            retailerDropDown: retailerDropdown,
            merchandise: merchandiseDropDown,
            region: regionDropDown,
            requestedDropDown: requestedDropDown,
            paymentType: paymentType);

        return depotProductRetailer;
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<List<RetailerPojo>> saveAllRetailer(
      List<Retailer> listOfRetailers) async {
    String? accessToken;
    ApiHelper appInterceptors = ApiHelper();
    accessToken = await appInterceptors.getUserAccessToken();

    List<RetailerModel> retailerPojoModelList = [];

    for (var i = 0; i < listOfRetailers.length; i++) {
      var saveListOfRetailers = listOfRetailers[i];
      String as = saveListOfRetailers.address.toString();

      RetailerModel saveListOfRetailersModel = RetailerModel(
        address: as,
        contactNumber: saveListOfRetailers.contactNumber.toString(),
        contactPerson: saveListOfRetailers.contactPerson.toString(),
        latitude: saveListOfRetailers.latitude,
        longitude: saveListOfRetailers.longitude,
        name: saveListOfRetailers.name.toString(),
        region: saveListOfRetailers.region,
        retailerClass: saveListOfRetailers.retailerClass,
        retailerType: saveListOfRetailers.retailerType,
      );

      retailerPojoModelList.add(saveListOfRetailersModel);
    }

    var saveRetailerInJson = retailerPojoModelList
        .map((saveListOfRetailersModel) => saveListOfRetailersModel.toJson())
        .toList();

    var jsonEncodedAnswer = jsonEncode(saveRetailerInJson);
    try {
      Response response = await dio.post(
        ApiUrl.saveAllRetailer,
        data: jsonEncodedAnswer,
        options: Options(
          contentType: "application/json",
          headers: <String, String>{
            'Authorization': 'Bearer ' + accessToken!,
          },
        ),
      );

      if (response.data["status"] == true) {
        return Future.value([]);
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<SaveUserDetailsDataModel> saveUserDetails(
      SaveUserDetailsDataModel saveUserDetailsDataModel) async {
    String? accessToken;
    ApiHelper appInterceptors = ApiHelper();
    accessToken = await appInterceptors.getUserAccessToken();
    SaveUserDetailsDataModel saveUserDetailsData = SaveUserDetailsDataModel(
      id: saveUserDetailsDataModel.id,
      email: saveUserDetailsDataModel.email,
      phoneNumber: saveUserDetailsDataModel.phoneNumber,
      roleId: saveUserDetailsDataModel.roleId,
      roleName: saveUserDetailsDataModel.roleName,
      userDetail: UserDetailsModel(
        fullName: saveUserDetailsDataModel.userDetail!.fullName,
        gender: saveUserDetailsDataModel.userDetail!.gender,
        permanentAddress: saveUserDetailsDataModel.userDetail!.permanentAddress,
        temporaryAddress: saveUserDetailsDataModel.userDetail!.temporaryAddress,
        contactNumber2: saveUserDetailsDataModel.userDetail!.contactNumber2,
        dob: saveUserDetailsDataModel.userDetail!.dob,
        id: saveUserDetailsDataModel.userDetail!.id,
        userDocument: saveUserDetailsDataModel.userDetail!.userDocument,
      ),
    );

    var saveUserDetailsDataModelInJson = saveUserDetailsData.toJson();
    var jsonEncodedSalesPerson = jsonEncode(saveUserDetailsDataModelInJson);
    try {
      Response response = await dio.post(
        ApiUrl.saveUser,
        data: jsonEncodedSalesPerson,
        options:
            Options(contentType: "application/json", headers: <String, String>{
          'Authorization': 'Bearer ' + accessToken!,
        }),
      );
      if (response.statusCode == 200) {
        SaveUserDetailsDataModel salesPerson =
            SaveUserDetailsDataModel.fromJson(response.data["data"]);
        return salesPerson;
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<String> requestLeave(Leave leave) async {
    String? accessToken;
    ApiHelper appInterceptors = ApiHelper();
    accessToken = await appInterceptors.getUserAccessToken();
    LeaveModel leaveModel = LeaveModel(
        fromDate: leave.fromDate,
        toDate: leave.toDate,
        userId: leave.userId,
        reason: leave.reason);

    var leaveInJson = leaveModel.toJson();
    var encodedJson = jsonEncode(leaveInJson);
    try {
      Response response = await dio.post(
        ApiUrl.requestLeave,
        data: encodedJson,
        options:
            Options(contentType: "application/json", headers: <String, String>{
          'Authorization': 'Bearer ' + accessToken!
          //+ accessToken!,
        }),
      );

      if (response.data["status"] == true) {
        return response.data["message"];
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<bool> flagChecker() async {
    String? accessToken;
    ApiHelper appInterceptors = ApiHelper();
    accessToken = await appInterceptors.getUserAccessToken();

    dio.interceptors.add(InterceptorsWrapper(onError: (error, handler) {
      if (error.response?.statusCode == 401) {
        print("not okay");
      }
    }));

    try {
      Response response = await dio.get(
        ApiUrl.flagChecker,
        options:
            Options(contentType: "application/json", headers: <String, String>{
          'Authorization': 'Bearer ' + accessToken!
          //+ accessToken!,
        }),
      );

      if (response.data["status"] == true) {
        bool flag = response.data["data"];
        return flag;
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<String> refreshToken() async {
    String? accessToken;
    ApiHelper appInterceptors = ApiHelper();
    accessToken = await appInterceptors.getUserAccessToken();
    const String _clientId = 'clientId';
    const String _clientSecret = 'secret';
    String p = base64Encode(utf8.encode('$_clientId:$_clientSecret'));
    print(p);

    try {
      Response response = await dio.post(
        ApiUrl.refreshToken,
        queryParameters: <String, String>{
          'grant_type': 'refresh_token',
          'refresh_token': "5686e02d-1e31-4f24-8108-87b6c3e85cca",
        },
        options: Options(
          contentType: "application/json",
          headers: {
            'Authorization': 'Basic ' +
                base64Encode(utf8.encode('$_clientId:$_clientSecret'))
          },
        ),
      );
      if (response.statusCode == 200) {
        UserDataModel userData = UserDataModel.fromJson(response.data);
        return "userData";
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      throw ServerException();
    }
  }
}
