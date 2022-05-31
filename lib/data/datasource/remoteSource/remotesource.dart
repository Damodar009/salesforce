import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/data/datasource/local_data_sources.dart';
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
import '../../../domain/entities/merchandise.dart';
import '../../../domain/entities/products.dart';
import '../../../domain/entities/region.dart';
import '../../../domain/entities/retailerDropDown.dart';
import '../../../domain/entities/retailerType.dart';
import '../../../domain/usecases/hiveUseCases/hiveUseCases.dart';
import '../../../error/exception.dart';
import '../../../injectable.dart';
import '../../../utils/hiveConstant.dart';
import '../../models/Userdata.dart';
import '../../models/DepotModel.dart';
import '../../models/Products.dart';
import '../../models/RetailerType.dart';
import '../../models/merchandiseModel.dart';
import '../../models/regionModel.dart';
import '../../models/retailerDropDownModel.dart';
import '../../models/userDetailModel.dart';
import '../local_data_sources.dart';

abstract class RemoteSource {
  Future<UserDataModel> login(String username, String password);

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

        // jsonEncode(userData.to)

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
    String? userid;
    String? accessToken;
    print("object1233444");
    Box box = await Hive.openBox(HiveConstants.userdata);
    print("iver below");

    var access_Token = useCaseForHiveImpl.getValueByKey(box, "access_token");
    access_Token.fold((l) => {print("failed")},
        (r) => {accessToken = r!, print(r.toString())});

    var successOrFailed = useCaseForHiveImpl.getValueByKey(box, "userid");
    successOrFailed.fold(
        (l) => {print("failed")}, (r) => {userid = r!, print(r.toString())});

    try {
      Response response = await dio.get(
        ApiUrl.getSalesStaff + userid!,
        options: Options(
          headers: <String, String>{'Authorization': 'Bearer ' + accessToken!},
        ),
      );

      print("Response code of getUserData ${response.statusCode}");
      print(response.data);

      if (response.data["status"] == true) {
        print(response.data);
        UserDetailsDataModel userDetailsData =
            UserDetailsDataModel.fromJson(response.data["data"]);

        // hive.savetoken(userDetailsData: userDetailsData);

        // hive.showtoken();
        print(userDetailsData);
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
  Future<String?> postDataToApi() {
    // TODO: implement postSurveyAnswer
    throw UnimplementedError();
  }

  @override
  Future<String> changePassword(String oldpassword, String newPassword) async {
    String? userid;
    String? accessToken;
    Box box = await Hive.openBox(HiveConstants.userdata);

    var accessTokenSuccessOrFailed =
        useCaseForHiveImpl.getValueByKey(box, "access_token");
    accessTokenSuccessOrFailed.fold((l) => {print("failed")},
        (r) => {accessToken = r!, print(r.toString())});

    var successOrFailed = useCaseForHiveImpl.getValueByKey(box, "userid");
    successOrFailed.fold(
        (l) => {print("failed")}, (r) => {userid = r!, print(r.toString())});
    print("this is password");

    print(oldpassword);
    print(newPassword);
    print(
      ApiUrl.changePassword,
    );
    try {
      Response response = await dio.post(
        ApiUrl.changePassword,
        data: <String, String>{
          'oldPassword': oldpassword,
          'newPassword': newPassword,
          'userId': userid!
        },
        options: Options(
          headers: <String, String>{'Authorization': 'Bearer ' + accessToken!},
        ),
      );
      print("this is change passowrd");
      print(response.statusCode);
      if (response.data["status"] == true) {
        print(response.data);
        print("print(response.statusCode);");
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

    Box box = await Hive.openBox(HiveConstants.userdata);

    dynamic accessToken = useCaseForHiveImpl.getValueByKey(box, "access_token");
    try {
      Response response = await dio.get(
        ApiUrl.saveSalesDataCollection,
        options: Options(
          headers: <String, String>{
            'Authorization': 'Bearer ' + accessToken,
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

    Box box = await Hive.openBox(HiveConstants.userdata);
    final signInLocalDataSource = getIt<SignInLocalDataSource>();

    //dynamic accessToken = useCaseForHiveImpl.getValueByKey(box, "access_token");

    try {
      print("inside depot product retailer");
      UserDataModel? userInfo =
          await signInLocalDataSource.getUserDataFromLocal();
      print(userInfo!.access_token);
      Response response = await dio.get(
        ApiUrl.depotProductAndRetailor,
        options: Options(
          headers: <String, String>{
            'Authorization': 'Bearer 823402f6-96dd-4b0d-a0f8-6d0af43a876c'
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

        List<RetailerDropDown> retailerDropdown = (response.data["data"]
                ["retailerDropDown"] as List)
            .map((sectorModel) => RetailerDropDownModel.fromJson(sectorModel))
            .toList();

        List<MerchandiseDropDown> merchandiseDropDown = (response.data["data"]
                ["depotDetails"] as List)
            .map(
                (sectorModel) => MerchandiseDropDownModel.fromJson(sectorModel))
            .toList();

        List<RegionDropDown> regionDropDown =
            (response.data["data"]["regionDropDown"] as List)
                .map((sectorModel) => RegionDropDownModel.fromJson(sectorModel))
                .toList();

        depotProductRetailer = DepotProductRetailer(
            products: products,
            retailerType: retailerTypes,
            depots: depots,
            retailerDropDown: retailerDropdown,
            merchandise: merchandiseDropDown,
            region: regionDropDown);

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
      List<RetailerPojo> listOfRetailers) async {
    String? accessToken;
    Box box = await Hive.openBox(HiveConstants.userdata);

    var accessTokenSuccessOrFailed =
        useCaseForHiveImpl.getValueByKey(box, "access_token");
    accessTokenSuccessOrFailed.fold((l) => {print("failed")},
        (r) => {accessToken = r!, print(r.toString())});

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

    //todo implement authorization token
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
      throw ServerException();
    }
  }

  @override
  Future<SaveUserDetailsDataModel> saveUserDetails(
      SaveUserDetailsDataModel saveUserDetailsDataModel) async {
    print(saveUserDetailsDataModel);

    print("saveUserDetailsRemoteDataSource");

    String? accessToken;
    print("okay");

    UserDataModel? userInfo =
        await signInLocalDataSource.getUserDataFromLocal();
    print("okay");

    print(userInfo!.access_token);

    accessToken = userInfo.access_token;

    print("saveUserDetailsRemoteDataSource access token is $accessToken ");

    print(userInfo);

    print("this is access token");

    print(accessToken);

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

    print(jsonEncodedSalesPerson);

    try {
      Response response = await dio.post(
        ApiUrl.saveUser,
        data: jsonEncodedSalesPerson,
        options:
            Options(contentType: "application/json", headers: <String, String>{
          'Authorization': 'Bearer ' + accessToken!,
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
