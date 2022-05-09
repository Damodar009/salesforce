import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/domain/entities/salesPerson.dart';
import '../../../error/exception.dart';
import '../../../utils/apiUrl.dart';
import '../../models/salesPersonModel.dart';

abstract class SalesTeamRemoteSource {
  Future<SalesPerson> saveSalesPerson(SalesPerson salesPerson);
}

@Injectable(as: SalesTeamRemoteSource)
class SalesTeamRemoteSourceImpl implements SalesTeamRemoteSource {
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
    print(jsonEncodedSalesPerson);

    try {
      Response response = await dio.post(
        ApiUrl.saveUser,
        data: jsonEncodedSalesPerson,
        options: Options(
          contentType: "application/json",
          headers: <String, String>{
            'Authorization': 'Bearer 13d1786f-1bde-4bd7-8ae9-d9b603fe97d6'
          },
        ),
      );
      print("xdfgdfgdsgfdsgcgxcb");
      if (response.data["status"] == true) {
        print("xcgxcb");
        print(response.data["data"]);
        SalesPerson salesPerson =
            SalesPersonModel.fromJson(response.data["data"]);
        print("this is salesperson data ");
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
