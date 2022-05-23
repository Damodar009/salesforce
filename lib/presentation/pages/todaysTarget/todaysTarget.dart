import 'package:hive/hive.dart';
import 'package:salesforce/injectable.dart';
import 'package:salesforce/utils/hiveConstant.dart';
import '../../../domain/usecases/hiveUseCases/hiveUseCases.dart';

class TodaysTarget {
  var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();
  getTotalOutlets() async {
    List<dynamic> totoOutlets = [];
    List<dynamic> newOutlests = await getNewOutlets();
    totoOutlets.addAll(newOutlests);

  }

  Future<List> getNewOutlets() async {
    List<dynamic> retailer = [];
    Box box = await Hive.openBox(HiveConstants.newRetailer);
    var successOrFailed = useCaseForHiveImpl.getAllValuesFromHiveBox(box);
    successOrFailed.fold(
        (l) => {print("this is so sad")}, (r) => {retailer.addAll(r)});

    return retailer;
  }

  getTotalOutletsVisited() {}
  getSalesData() async {
    List<dynamic> salesData = [];
    Box box = await Hive.openBox(HiveConstants.newRetailer);
    var successOrFailed = useCaseForHiveImpl.getAllValuesFromHiveBox(box);
    successOrFailed.fold(
        (l) => {print("this is so sad")}, (r) => {salesData.addAll(r)});
    return salesData;
  }
}
