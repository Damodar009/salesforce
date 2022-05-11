import 'package:dio/dio.dart';
import 'package:salesforce/domain/entities/products.dart';
import 'package:salesforce/domain/entities/retailerType.dart';
import '../../../domain/entities/depot.dart';
import '../../../domain/entities/depotProductRetailer.dart';
import '../../../error/exception.dart';
import '../../../utils/apiUrl.dart';
import '../../models/DepotModel.dart';
import '../../models/Products.dart';
import '../../models/RetailerType.dart';

abstract class GetDepotProductAndRetailer {
  Future<DepotProductRetailer> getDepotProductAndRetailer();
}

class GetDepotProductAndRetailerImpl implements GetDepotProductAndRetailer {
  Dio dio = Dio();
  @override
  Future<DepotProductRetailer> getDepotProductAndRetailer() async {
    try {
      print("staeting ");
      Response response = await dio.post(
        ApiUrl.depotProductAndRetailor,

        // options: Options(
        //   contentType: "application/x-www-form-urlencoded",
        //   headers: <String, String>{
        //     'Authorization': 'Basic ' +
        //         base64Encode(utf8.encode('$_clientId:$_clientSecret'))
        //   },
        // ),
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
      print(e);
      throw ServerException();
    }
  }
}
