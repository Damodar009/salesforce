import 'package:dio/dio.dart';
import 'package:salesforce/data/models/merchandiseModel.dart';
import 'package:salesforce/data/models/regionModel.dart';
import 'package:salesforce/data/models/retailerDropDownModel.dart';
import 'package:salesforce/domain/entities/merchandise.dart';
import 'package:salesforce/domain/entities/products.dart';
import 'package:salesforce/domain/entities/region.dart';
import 'package:salesforce/domain/entities/requestedDropDown.dart';
import 'package:salesforce/domain/entities/retailerDropDown.dart';
import 'package:salesforce/domain/entities/retailerType.dart';
import 'package:salesforce/domain/usecases/hiveUseCases/hiveUseCases.dart';
import '../../../domain/entities/depot.dart';
import '../../../domain/entities/depotProductRetailer.dart';
import '../../../domain/entities/paymentType.dart';
import '../../../error/exception.dart';
import '../../../injectable.dart';
import '../../../utils/AapiUtils.dart';
import '../../../utils/apiUrl.dart';
import '../../models/DepotModel.dart';
import '../../models/Products.dart';
import '../../models/RetailerType.dart';
import '../../models/Userdata.dart';
import '../../models/paymentTypeModel.dart';
import '../../models/requestedDropDownModel.dart';
import '../local_data_sources.dart';

abstract class GetDepotProductAndRetailer {
  Future<DepotProductRetailer> getDepotProductAndRetailer();
}

class GetDepotProductAndRetailerImpl implements GetDepotProductAndRetailer {
  Dio dio = Dio();
  var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();

  @override
  Future<DepotProductRetailer> getDepotProductAndRetailer() async {
    final signInLocalDataSource = getIt<SignInLocalDataSource>();
    String? accessToken;
    AppInterceptors appInterceptors = AppInterceptors();
    accessToken = await appInterceptors.getUserAccessToken();
    try {
      UserDataModel? userInfo =
          await signInLocalDataSource.getUserDataFromLocal();
      print(userInfo!.access_token);
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
                ["depotDetails"] as List)
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
}
