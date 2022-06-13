import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/domain/entities/SalesData.dart';
import 'package:salesforce/domain/entities/attendence.dart';
import 'package:salesforce/domain/usecases/useCaseForAttebdenceSave.dart';
import 'package:salesforce/domain/usecases/useCaseForSalesData.dart';
import 'package:salesforce/domain/usecases/usecasesForRemoteSource.dart';
import '../../data/datasource/local_data_sources.dart';
import '../../injectable.dart';
import '../../utils/hiveConstant.dart';
import '../entities/retailer.dart';
import 'hiveUseCases/hiveUseCases.dart';

@injectable
class AllLocalDataToApi {
  var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();
  var useCaseForSalesDataImpl = getIt<UseCaseForSalesDataImpl>();
  var checklocalDataSend = getIt<SignInLocalDataSourceImpl>();
  bool sendAllLocalDataToAPi(
      {List<SalesData>? salesData,
      List<dynamic>? locations,
      List<Retailer>? mewOutlets,
      Attendence? attendance}) {
    bool allDataSend = true;

    //sales data
    if (salesData != null) {
      useCaseForSalesDataImpl
          .saveSalesData(salesData)
          .then((value) => value.fold(
              (l) => {
                    allDataSend = false,
                  },
              (r) => {deleteSalesData()}));
    }
    // if (locations != null) {
    //   for (var i = 0; i < locations.length; i++) {}
    // }
    if (mewOutlets != null) {
      var useCaseForRemoteSourceimpl = getIt<UseCaseForRemoteSourceimpl>();
      useCaseForRemoteSourceimpl
          .saveAllRetailer(mewOutlets)
          .then((value) => value.fold(
              (l) => {
                    allDataSend = false,
                  },
              (r) => {
                    deleteRetailerData(),
                  }));
    }
    if (attendance != null) {
      var useCaseForAttendanceImpl = getIt<UseCaseForAttendenceImpl>();
      useCaseForAttendanceImpl
          .attendenceSave(attendance)
          .then((value) => value.fold(
              (l) => {
                    allDataSend = false,
                  },
              (r) => {deleteCheckoutAndCheckIn()}));
    }
    return allDataSend;
  }

  getAllDatFromApiAndSend() async {
    List<SalesData>? salesData;
    List<Retailer>? mewOutlets;
    Attendence? attendance;
    salesData = await getSalesData();
    mewOutlets = await getNewRetailers();
    attendance = await getAttendanceDataFromHiveBox();

    bool allDataSend = sendAllLocalDataToAPi(
        salesData: salesData,
        locations: null,
        mewOutlets: mewOutlets,
        attendance: attendance);
    if (allDataSend) {
      checklocalDataSend.setLocalDataChecker(false);
    }
  }

//todo check cast
  Future<List<Retailer>?> getNewRetailers() async {
    List<Retailer>? retailer;
    Box newRetailerBox = await Hive.openBox(HiveConstants.newRetailer);
    var successOrFailed =
        useCaseForHiveImpl.getAllValuesFromHiveBox(newRetailerBox);
    successOrFailed.fold((l) => {print("retrieving retailers data failed")},
        (r) => {retailer = r.cast<Retailer>(), print("casting is succesfull")});

    return retailer;
  }

  Future<List<SalesData>?> getSalesData() async {
    List<SalesData>? salesData;
    Box salesBox = await Hive.openBox(HiveConstants.salesDataCollection);
    var successOrFailed = useCaseForHiveImpl.getAllValuesFromHiveBox(salesBox);
    successOrFailed.fold(
        (l) => {print("retrieving sales data failed")},
        (r) => {
              salesData = r.cast<SalesData>(),
            });
    return salesData;
  }

  Future<Attendence?> getAttendanceDataFromHiveBox() async {
    Attendence? checkout;
    Box box = await Hive.openBox(HiveConstants.attendence);
    var failureOrSuccess = useCaseForHiveImpl.getValueByKey(
        box, HiveConstants.attendenceCheckOutKey);

    failureOrSuccess.fold(
        (l) => {
              print("retrieving attendance data failed"),
            },
        (r) => {
              checkout = r.cast<Attendence>(),
            });
    return checkout;
  }

  //delete data from retailers box , salesdata box , attendance box
  deleteRetailerData() async {
    Box salesBox = await Hive.openBox(HiveConstants.newRetailer);
    salesBox.clear();
  }

  deleteSalesData() async {
    Box salesBox = await Hive.openBox(HiveConstants.salesDataCollection);
    salesBox.clear();
  }

  deleteCheckoutAndCheckIn() async {
    Box checkOutBox = await Hive.openBox(HiveConstants.attendence);
    checkOutBox.delete(HiveConstants.attendenceCheckOutKey);
  }
}
