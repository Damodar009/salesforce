import 'package:hive/hive.dart';
import 'package:salesforce/domain/entities/SalesData.dart';
import 'package:salesforce/domain/entities/retailerDropDown.dart';
import 'package:salesforce/injectable.dart';
import 'package:salesforce/utils/hiveConstant.dart';
import '../../../domain/entities/retailer.dart';
import '../../../domain/usecases/hiveUseCases/hiveUseCases.dart';
import '../../../domain/usecases/useCaseForSalesData.dart';
import '../../../domain/usecases/usecasesForRemoteSource.dart';

class TodayTarget {
  var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();
  var useCaseForSalesDataImpl = getIt<UseCaseForSalesDataImpl>();
// get length
  Future<int> getTotalOutlets() async {
    int totalOutlets = 0;
    List<RetailerDropDown>? retailerDropDownList = await getTotalOutLetList();
    if (retailerDropDownList != null) {
      totalOutlets = retailerDropDownList.length;
    }
    return totalOutlets;
  }

//get list
  Future<List<RetailerDropDown>?> getTotalOutLetList() async {
    List<RetailerDropDown> retailerDropDownList = [];
    Box totalOutletBox =
        await Hive.openBox(HiveConstants.depotProductRetailers);
    var successOrFailed = useCaseForHiveImpl.getValuesByKey(
        totalOutletBox, HiveConstants.retailerDropdownKey);

    successOrFailed.fold(
        (l) => {print("get total outlet failed")},
        (r) => {
              for (int i = 0; i < r.length; i++)
                {
                  retailerDropDownList.add(r[i]),
                },
              print("get total outlet passed"),
              print(retailerDropDownList)
            });
    return retailerDropDownList;
  }

  Future<int> getNewOutlets() async {
    int retailer = 0;
    List<RetailerDropDown>? retailers = [];
    retailers = await getNewOutletsList();
    if (retailers != null) {
      retailer = retailers.length;
    }
    return retailer;
  }

  Future<List<RetailerDropDown>?> getNewOutletsList() async {
    List<RetailerDropDown> retailers = [];
    Box newRetailerBox = await Hive.openBox(HiveConstants.newRetailer);
    var successOrFailed =
        useCaseForHiveImpl.getAllValuesFromHiveBox(newRetailerBox);
    successOrFailed.fold(
        (l) => {
              print("get mew outlet failed"),
            },
        (r) => {
              for (int i = 0; i < r.length; i++) {retailers.add(r[i])}
            });

    List<dynamic> salesData = await getSalesData();
    for (var i = 0; i < salesData.length; i++) {
      if (salesData[i].retailerPojo != null) {
        retailers.add(salesData[i].retailerPojo);
      }
    }
    return retailers;
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
        (l) => {print("sales data failed")},
        (r) => {
              print("sales data is passed"),
              salesData.addAll(r),
              print(salesData)
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
        (l) => {},
        (r) => {
              length = r.length,
              for (var i = 0; i < r.length; i++) {retailer.add(r[i])}
            });

    if (retailer.isNotEmpty) {
      var useCaseForRemoteSourceimpl = getIt<UseCaseForRemoteSourceimpl>();
      var successOrFailed =
          await useCaseForRemoteSourceimpl.saveAllRetailer(retailer);

      successOrFailed.fold((l) => {}, (r) => {});
    } else {}
  }

  getAndSendSalesDataToApi(List<dynamic> salesData) async {
    List<SalesData> salesDataList = [];
    for (var i = 0; i < salesData.length; i++) {
      salesDataList.add(salesData[i]);
    }

    useCaseForSalesDataImpl.saveSalesData(salesDataList);
  }

  sendCheckInAndCheckoutDataToApi() async {
    Box salesBox = await Hive.openBox(HiveConstants.salesDataCollection);
    var successOrFailed = useCaseForHiveImpl.getAllValuesFromHiveBox(salesBox);
    successOrFailed.fold((l) => null, (r) => null);
  }
}
