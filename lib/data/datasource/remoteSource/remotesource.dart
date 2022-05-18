import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/data/datasource/hive.dart';
import 'package:salesforce/data/models/RetailerPojo.dart';
import 'package:salesforce/data/models/SalesDataCollection.dart';
import 'package:salesforce/data/models/SaveUserDetailsDataModel.dart';
import 'package:salesforce/data/models/userDetailsDataModel.dart';
import 'package:salesforce/domain/entities/retailerPojo.dart';
import 'package:salesforce/domain/entities/sales_data_collection.dart';
import 'package:salesforce/domain/entities/userData.dart';
import 'package:salesforce/domain/entities/userDetailsData.dart';
import 'package:salesforce/utils/apiUrl.dart';
import '../../../domain/entities/depot.dart';
import '../../../domain/entities/depotProductRetailer.dart';
import '../../../domain/entities/products.dart';
import '../../../domain/entities/retailerType.dart';
import '../../../error/exception.dart';
import '../../models/Userdata.dart';
import '../../models/DepotModel.dart';
import '../../models/Products.dart';
import '../../models/RetailerType.dart';
import '../../models/userDetailModel.dart';

abstract class RemoteSource {
  Future<UserData> login(String username, String password);
  Future<String> changePassword(String oldpassword, String newPassword);
  Future<String> postImage();
  Future<String> getProductList();
  Future<String> getRegionList();
  Future<String> attendenceSave();
  Future<List<SalesDataCollection>> saveSalesDataCollection();
  Future<String?> postDataToApi();
  Future<DepotProductRetailer> getDepotProductAndRetailer();
  Future<UserDetailsData> getUserDetailsData();
  Future<List<RetailerPojo>> saveAllRetailer(
      List<RetailerPojo> listOfRetailers);

  Future<SaveUserDetailsDataModel> saveUserDetails(
      SaveUserDetailsDataModel saveUserDetailsDataModel);
}

@Injectable(as: RemoteSource)
class RemoteSourceImplementation implements RemoteSource {
  Dio dio = Dio();
  SaveLocally hive = SaveLocally();

  RemoteSourceImplementation();

  @override
  Future<UserData> login(String username, String password) async {
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
        UserData userData = UserDataModel.fromJson(response.data);

        print(response.data);

        // hive.savetoken(userdata: userData);
        // hive.showtoken()

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
    print("object1233444");
    // Box box = await hive.openBox();

    // String accessToken = box.get('access_token');

    // String userId = box.get('userid');

    // try {
    Response response = await dio.get(
      ApiUrl.getSalesStaff + 'Fii0wdochNnYL15BnZAJMg==',
      options: Options(
        headers: <String, String>{
          'Authorization': 'Bearer 5bcd338e-79a6-4681-bdb8-7bd7d24fad0f'
        },
      ),
    );

    print("Response code of getUserData ${response.statusCode}");
    print(response.data);

    if (response.data["status"] == true) {
      UserDetailsDataModel userDetailsData =
          UserDetailsDataModel.fromJson(response.data["data"]);

      // hive.savetoken(userDetailsData: userDetailsData);

      // hive.showtoken();

      return userDetailsData;
    } else {
      throw ServerException();
    }
    // } on DioError catch (e) {
    //   throw ServerException();
    // }
  }

  @override
  Future<String?> postDataToApi() {
    // TODO: implement postSurveyAnswer
    throw UnimplementedError();
  }

  @override
  Future<String> changePassword(String oldpassword, String newPassword) async {
    Box box = await hive.openBox();

    String accessToken = box.get('access_token');

    String userId = box.get('userid');
    try {
      Response response = await dio.post(
        ApiUrl.changePassword,
        data: <String, String>{
          'oldPassword': oldpassword,
          'newPassword': newPassword,
          'userId': userId
        },
        options: Options(
          headers: <String, String>{'Authorization': 'Bearer ' + accessToken},
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

//todo
  @override
  Future<String> postImage() async {
    try {
      Response response = await dio.post(
        ApiUrl.login,
        data: <String, String>{'grant_type': 'password'},
        options: Options(
          contentType: "application/x-www-form-urlencoded",
          headers: <String, String>{'Authorization': 'Basic '},
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
  Future<String> attendenceSave() {
    // TODO: implement attendenceSave
    throw UnimplementedError();
  }

  @override
  Future<String> getProductList() {
    // TODO: implement getProductList
    throw UnimplementedError();
  }

  @override
  Future<String> getRegionList() {
    // TODO: implement getRegionList
    throw UnimplementedError();
  }

  @override
  Future<List<SalesDataCollection>> saveSalesDataCollection() async {
    //todo implement authorization token
    try {
      Response response = await dio.get(
        ApiUrl.saveSalesDataCollection,
        options: Options(
          headers: <String, String>{
            'Authorization': 'Bearer 2c0f2635-6d0a-46af-b822-0a6cf55df729'
          },
        ),
      );

      if (response.data["status"] == true) {
        List<SalesDataCollection> saveSalesDataCollection =
            (response.data as List)
                .map((e) => SalesDataCollectionModel.fromJson(e))
                .toList();

        return saveSalesDataCollection;
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<DepotProductRetailer> getDepotProductAndRetailer() async {
    //todo implement authorization token
    try {
      Response response = await dio.get(
        ApiUrl.depotProductAndRetailor,
        options: Options(
          headers: <String, String>{
            'Authorization': 'Bearer bb81196a-bc85-4c26-b3af-abae634a3795'
          },
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

        depotProductRetailer = DepotProductRetailer(
            products: products, retailerType: retailerTypes, depots: depots);

        return depotProductRetailer;
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<RetailerPojo>> saveAllRetailer(
      List<RetailerPojo> listOfRetailers) async {
    List<RetailerPojoModel> retailerPojoModelList = [];

    for (var i = 0; i < listOfRetailers.length; i++) {
      var saveListOfRetailers = listOfRetailers[i];

      RetailerPojoModel saveListOfRetailersModel = RetailerPojoModel(
        address: saveListOfRetailers.address,
        contactNumber: saveListOfRetailers.contactNumber,
        contactPerson: saveListOfRetailers.contactPerson,
        latitude: saveListOfRetailers.latitude,
        longitude: saveListOfRetailers.longitude,
        name: saveListOfRetailers.name,
        region: saveListOfRetailers.region,
        retailerClass: saveListOfRetailers.retailerClass,
        retailerType: saveListOfRetailers.retailerType,
      );

      retailerPojoModelList.add(saveListOfRetailersModel);
    }

    var saveRetailesInJson = retailerPojoModelList
        .map((saveListOfRetailersModel) => saveListOfRetailersModel.toJson())
        .toList();

    var jsonEncodedAnswer = jsonEncode(saveRetailesInJson);

    Box box = await hive.openBox();

    String accessToken = box.get('access_token');

    //todo implement authorization token
    try {
      Response response = await dio.post(
        ApiUrl.saveAllRetailer,
        data: jsonEncodedAnswer,
        options: Options(
          contentType: "application/json",
          headers: <String, String>{
            'Authorization': 'Bearer ' + accessToken,
          },
        ),
      );

      if (response.data["status"] == true) {
        return Future.value([]);
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<SaveUserDetailsDataModel> saveUserDetails(
      SaveUserDetailsDataModel saveUserDetailsDataModel) async {
    print("saveUserDetailsRemoteDataSource");

    SaveUserDetailsDataModel saveUserDetailsData = SaveUserDetailsDataModel(
        id: saveUserDetailsDataModel.id,
        email: saveUserDetailsDataModel.email,
        phoneNumber: saveUserDetailsDataModel.phoneNumber,
        roleId: saveUserDetailsDataModel.roleId,
        roleName: saveUserDetailsDataModel.roleName,
        userDetail: UserDetailsModel(
          fullName: saveUserDetailsDataModel.userDetail!.fullName,
          gender: saveUserDetailsDataModel.userDetail!.gender,
          permanentAddress:
              saveUserDetailsDataModel.userDetail!.permanentAddress,
          temporaryAddress:
              saveUserDetailsDataModel.userDetail!.temporaryAddress,
          contactNumber2: saveUserDetailsDataModel.userDetail!.contactNumber2,
          dob: saveUserDetailsDataModel.userDetail!.dob,
          id: saveUserDetailsDataModel.userDetail!.id,
          userDocument: saveUserDetailsDataModel.userDetail!.userDocument,
          user_detail_id: saveUserDetailsDataModel.userDetail!.user_detail_id,
        ));

    var saveUserDetailsDataModelInJson = saveUserDetailsData.toJson();
    var jsonEncodedSalesPerson = jsonEncode(saveUserDetailsDataModelInJson);

    print(jsonEncodedSalesPerson);

    try {
      Response response = await dio.post(
        ApiUrl.saveUser,
        data: jsonEncodedSalesPerson,
        options:
            Options(contentType: "application/json", headers: <String, String>{
          'Authorization': 'Bearer 5bcd338e-79a6-4681-bdb8-7bd7d24fad0f',
        }),
      );

      print('this is edit repo');

      print(response.statusCode);

      if (response.statusCode == 200) {
        print(response.data);

        print('above is response data');
        SaveUserDetailsDataModel salesPerson =
            SaveUserDetailsDataModel.fromJson(response.data["data"]);

        print(salesPerson);

        return salesPerson;
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
