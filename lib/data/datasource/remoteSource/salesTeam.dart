import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/domain/entities/salesPerson.dart';
import 'package:salesforce/domain/usecases/hiveUseCases/hiveUseCases.dart';
import 'package:salesforce/injectable.dart';
import '../../../error/exception.dart';
import '../../../utils/AapiUtils.dart';
import '../../../utils/apiUrl.dart';
import '../../models/salesPersonModel.dart';

abstract class SalesTeamRemoteSource {
  Future<SalesPerson> saveSalesPerson(SalesPerson salesPerson);
}

@Injectable(as: SalesTeamRemoteSource)
class SalesTeamRemoteSourceImpl implements SalesTeamRemoteSource {
  var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();
  Dio dio = Dio();
  @override
  Future<SalesPerson> saveSalesPerson(SalesPerson salesPerson) async {
    SalesPersonModel salesPersonModel = SalesPersonModel(
        id: salesPerson.id,
        userDetails: salesPerson.userDetails,
        email: salesPerson.email,
        phoneNumber: salesPerson.phoneNumber,
        password: salesPerson.password,
        roleId: salesPerson.roleId);

    var salesPersonInJson = salesPersonModel.toJson();
    var jsonEncodedSalesPerson = jsonEncode(salesPersonInJson);
    String? accessToken;
    AppInterceptors appInterceptors = AppInterceptors();
    accessToken = await appInterceptors.getUserAccessToken();
    try {
      Response response = await dio.post(
        ApiUrl.saveUser,
        data: jsonEncodedSalesPerson,
        options: Options(
          contentType: "application/json",
          headers: <String, String>{'Authorization': 'Bearer ' + accessToken!},
        ),
      );
      if (response.data["status"] == true) {
        SalesPerson salesPerson =
            SalesPersonModel.fromJson(response.data["data"]);

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
