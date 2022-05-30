import 'package:hive/hive.dart';
import 'package:salesforce/injectable.dart';
import 'package:salesforce/utils/hiveConstant.dart';
import '../../../domain/usecases/hiveUseCases/hiveUseCases.dart';

class TodaysTarget {
  var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();
  Future<int> getTotalOutlets() async {
    int totalOutlets = 0;
    Box box = await Hive.openBox(HiveConstants.depotProductRetailers);
    var successOrFailed = useCaseForHiveImpl.getValuesByKey(
        box, HiveConstants.retailerDropdownKey);
    successOrFailed.fold(
        (l) => {print("getting retailer from local database is failed ")},
        (r) => {
              totalOutlets = r.length,
            });
    totalOutlets = await getNewOutlets();
    return totalOutlets;
  }

  Future<int> getNewOutlets() async {
    int retailer = 0;
    Box box = await Hive.openBox(HiveConstants.newRetailer);
    var successOrFailed = useCaseForHiveImpl.getAllValuesFromHiveBox(box);
    successOrFailed.fold(
        (l) => {print("this is so sad")}, (r) => {retailer = r.length});

    List<dynamic> salesData = await getSalesData();
    for (var i = 0; i < salesData.length; i++) {
      if (salesData[i].retailerPojo != null) {
        retailer = retailer + 1;
      }
    }
    return retailer;
  }

  getTotalOutletsVisitedToday() {
    int toalOutletVisitedToday = 0;
    List<dynamic> salesData = getSalesData();
    for (var i = 0; i < salesData.length; i++) {
      if (salesData[i].retailerPojo != null || salesData[i].retailer != null) {
        toalOutletVisitedToday = toalOutletVisitedToday + 1;
      }
    }
  }

  getSalesData() async {
    List<dynamic> salesData = [];
    Box boxs = await Hive.openBox(HiveConstants.salesDataCollection);
    var successOrFailed = useCaseForHiveImpl.getAllValuesFromHiveBox(boxs);
    successOrFailed.fold(
        (l) => {print("this is so sad")}, (r) => {salesData.addAll(r)});
    return salesData;
  }
}
