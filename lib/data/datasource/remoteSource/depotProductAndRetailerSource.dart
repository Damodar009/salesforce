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
      Response response = await dio.post(
        ApiUrl.depotProductAndRetailor,
        options: Options(
          contentType: "application/x-www-form-urlencoded",
          headers: <String, String>{
            'Authorization': 'Bearer 4ec360b3-5296-4d12-8719-4ae999679ec9'
          },
        ),
      );
      if (response.data["status"] == true) {


        print("product retailer dropdown");
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
//todo
        depotProductRetailer = DepotProductRetailer(
            products: products,
            retailerType: retailerTypes,
            depots: depots,
            retailerDropDown: [],
            merchandise: [],
            region: []);

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
