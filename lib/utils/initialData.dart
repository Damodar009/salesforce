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
    DepotProductRetailer? depotProdeuctRetailer;
    var failureOrsucess =
        await useCaseForRemoteSourceimpl.getDepotProductRetailerDropDown();
    failureOrsucess.fold((l) => {print("failedalksndadasd")},
        (r) => {depotProdeuctRetailer = r});

    return depotProdeuctRetailer;
  }

  savedepotProductRetailerDropDownToHiveBox(
      DepotProductRetailer? depotProductRetailer) async {
    if (depotProductRetailer != null) {
      Box box = await Hive.openBox(HiveConstants.depotProductRetailers);
      useCaseForHiveImpl.saveValueByKey(
          box, HiveConstants.depotKey, depotProductRetailer.depots);
      useCaseForHiveImpl.saveValueByKey(
          box, HiveConstants.productKey, depotProductRetailer.products);
      useCaseForHiveImpl.saveValueByKey(box, HiveConstants.retailerTypeKey,
          depotProductRetailer.retailerType);
    } else {
      print("failed");
    }
  }

  getAndSaveInitalData() async {
    DepotProductRetailer? depotProductRetailer;
    depotProductRetailer = await getDepotAndDropDownFromApi();

    await savedepotProductRetailerDropDownToHiveBox(depotProductRetailer);
  }
}
