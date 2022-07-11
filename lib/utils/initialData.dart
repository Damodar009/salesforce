import 'package:hive/hive.dart';
import '../domain/entities/depotProductRetailer.dart';
import '../domain/usecases/hiveUseCases/hiveUseCases.dart';
import '../domain/usecases/usecasesForRemoteSource.dart';
import '../injectable.dart';
import 'hiveConstant.dart';

class InitialData {
  var useCaseForRemoteSourceimpl = getIt<UseCaseForRemoteSourceimpl>();
  var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();
  Future<DepotProductRetailer?> getDepotAndDropDownFromApi() async {
    DepotProductRetailer? depotProductRetailer;
    var failureOrsucess =
        await useCaseForRemoteSourceimpl.getDepotProductRetailerDropDown();
    failureOrsucess.fold(
        (l) => {print("failed")}, (r) => {depotProductRetailer = r});

    return depotProductRetailer;
  }

  saveDepotProductRetailerDropDownToHiveBox(
      DepotProductRetailer? depotProductRetailer) async {
    if (depotProductRetailer != null) {
      Box box = await Hive.openBox(HiveConstants.depotProductRetailers);
      print("depotProductRetailer.depots");
      useCaseForHiveImpl.saveValueByKey(
          box, HiveConstants.depotKey, depotProductRetailer.depots);
      useCaseForHiveImpl.saveValueByKey(
          box, HiveConstants.productKey, depotProductRetailer.products);
      useCaseForHiveImpl.saveValueByKey(box, HiveConstants.retailerTypeKey,
          depotProductRetailer.retailerType);
      useCaseForHiveImpl.saveValueByKey(box, HiveConstants.retailerDropdownKey,
          depotProductRetailer.retailerDropDown);
      useCaseForHiveImpl.saveValueByKey(
          box, HiveConstants.regionKey, depotProductRetailer.region);
      useCaseForHiveImpl.saveValueByKey(
          box, HiveConstants.merchandiseKey, depotProductRetailer.merchandise);
      useCaseForHiveImpl.saveValueByKey(
          box, HiveConstants.paymentTypeKey, depotProductRetailer.paymentType);

      useCaseForHiveImpl.saveValueByKey(box, HiveConstants.requestOrders,
          depotProductRetailer.requestedDropDown);
    } else {}
  }

  getAndSaveInitalData() async {
    // bool? flag = await flagChecker();
    if (true) {
      DepotProductRetailer? depotProductRetailer;
      depotProductRetailer = await getDepotAndDropDownFromApi();

      await saveDepotProductRetailerDropDownToHiveBox(depotProductRetailer);
    } else {
      return;
    }
  }

  flagChecker() async {
    bool flag = true;
    await useCaseForRemoteSourceimpl.flagChecker().then((value) => {
          value.fold(
              (l) => {print("flag checker failed")},
              (r) => {
                    flag = r,
                  })
        });
    return flag;
  }
}
