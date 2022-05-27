import 'package:dio/dio.dart';
import 'package:salesforce/data/models/merchandiseModel.dart';
import 'package:salesforce/data/models/regionModel.dart';
import 'package:salesforce/data/models/retailerDropDownModel.dart';
import 'package:salesforce/domain/entities/merchandise.dart';
import 'package:salesforce/domain/entities/products.dart';
import 'package:salesforce/domain/entities/region.dart';
import 'package:salesforce/domain/entities/retailerDropDown.dart';
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
            'Authorization': 'Bearer 4ff45a34-268d-44e0-9f04-6dc95acd4044'
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
                ["depotDetails"] as List)
            .map((sectorModel) => RetailerDropDownModel.fromJson(sectorModel))
            .toList();

        List<MerchandiseDropDown> merchandiseDropDown = (response.data["data"]
                ["depotDetails"] as List)
            .map(
                (sectorModel) => MerchandiseDropDownModel.fromJson(sectorModel))
            .toList();

        List<RegionDropDown> regionDropDown =
            (response.data["data"]["depotDetails"] as List)
                .map((sectorModel) => RegionDropDownModel.fromJson(sectorModel))
                .toList();

//todo
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
}
