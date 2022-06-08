import 'package:hive/hive.dart';
import 'package:salesforce/domain/entities/SalesData.dart';
import 'package:salesforce/injectable.dart';
import 'package:salesforce/utils/hiveConstant.dart';
import '../../../domain/entities/retailer.dart';
import '../../../domain/usecases/hiveUseCases/hiveUseCases.dart';
import '../../../domain/usecases/useCaseForSalesData.dart';
import '../../../domain/usecases/usecasesForRemoteSource.dart';

class TodayTarget {
  var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();
  var useCaseForSalesDataImpl = getIt<UseCaseForSalesDataImpl>();

  Future<int> getTotalOutlets() async {
    int totalOutlets = 0;
    Box totalOutletBox =
        await Hive.openBox(HiveConstants.depotProductRetailers);
    var successOrFailed = useCaseForHiveImpl.getValuesByKey(
        totalOutletBox, HiveConstants.retailerDropdownKey);
    successOrFailed.fold(
        (l) => {print("getting retailer from local database is failed ")},
        (r) => {
              totalOutlets = r.length,
            });

    return totalOutlets;
  }

  Future<int> getNewOutlets() async {
    int retailer = 0;
    Box newRetailerBox = await Hive.openBox(HiveConstants.newRetailer);
    var successOrFailed =
        useCaseForHiveImpl.getAllValuesFromHiveBox(newRetailerBox);
    successOrFailed.fold(
        (l) => {print("this is so sad")},
        (r) => {
              retailer = r.length,
            });

    List<dynamic> salesData = await getSalesData();
    for (var i = 0; i < salesData.length; i++) {
      if (salesData[i].retailerPojo != null) {
        retailer = retailer + 1;
      }
    }
    return retailer;
  }

  Future<int> getTotalOutletsVisitedToday() async {
    int toalOutletVisitedToday = 0;
    List<dynamic> salesData = await getSalesData();
    for (var i = 0; i < salesData.length; i++) {
      if (salesData[i].retailerPojo != null || salesData[i].retailer != null) {
        toalOutletVisitedToday = toalOutletVisitedToday + 1;
      }
    }
    return toalOutletVisitedToday;
  }

  Future<List> getSalesData() async {
    List<dynamic> salesData = [];
    Box salesBox = await Hive.openBox(HiveConstants.salesDataCollection);
    var successOrFailed = useCaseForHiveImpl.getAllValuesFromHiveBox(salesBox);
    successOrFailed.fold(
        (l) => {print("this is so sad")},
        (r) => {
              salesData.addAll(r),
            });
    return salesData;
  }

  sendListOfNewRetailer() async {
    List<Retailer> retailer = [];
    Box newRetailerBox = await Hive.openBox(HiveConstants.newRetailer);
    var successOrFailed =
        useCaseForHiveImpl.getAllValuesFromHiveBox(newRetailerBox);
    int length;
    successOrFailed.fold(
        (l) => {print("this is so sad")},
        (r) => {
              length = r.length,
              for (var i = 0; i < r.length; i++)
                {retailer.add(r[i]), print(retailer)}
            });

    if (retailer.isNotEmpty) {
      var useCaseForRemoteSourceimpl = getIt<UseCaseForRemoteSourceimpl>();
      var successOrFailed =
          await useCaseForRemoteSourceimpl.saveAllRetailer(retailer);

      successOrFailed.fold(
          (l) => {
                print("retailer api is failed"),
              },
          (r) => {print(r)});
    } else {}
  }

  getAndSendSalesDataToApi(List<dynamic> salesData) async {
    List<SalesData> salesDataList = [];
    for (var i = 0; i < salesData.length; i++) {
      salesDataList.add(salesData[i]);
      print(salesData[i]);
    }
    print(" sending sales data to api");
    useCaseForSalesDataImpl.saveSalesData(salesDataList);
    print("success sending sales data to api");
    print("this is the length of sales data ");
    print(salesData.length);
  }

  sendCheckInAndCheckoutDataToApi() async {
    Box salesBox = await Hive.openBox(HiveConstants.salesDataCollection);
    var successOrFailed = useCaseForHiveImpl.getAllValuesFromHiveBox(salesBox);
    successOrFailed.fold((l) => null, (r) => null);
  }
}
