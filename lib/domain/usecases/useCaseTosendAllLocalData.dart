import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/domain/entities/SalesData.dart';
import 'package:salesforce/domain/entities/attendence.dart';
import 'package:salesforce/domain/entities/requestDeliver.dart';
import 'package:salesforce/domain/usecases/useCaseForAttebdenceSave.dart';
import 'package:salesforce/domain/usecases/useCaseForSalesData.dart';
import 'package:salesforce/domain/usecases/useCaseForSalesDataTrackCollection.dart';
import 'package:salesforce/domain/usecases/usecasesForRemoteSource.dart';
import 'package:salesforce/utils/dataChecker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/datasource/local_data_sources.dart';
import '../../injectable.dart';
import '../../utils/hiveConstant.dart';
import '../entities/retailer.dart';
import '../entities/saleslocationTrack.dart';
import 'hiveUseCases/hiveUseCases.dart';

@injectable
class AllLocalDataToApi {
  var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();
  var useCaseForSalesDataImpl = getIt<UseCaseForSalesDataImpl>();
  DataChecker dataChecker = DataChecker();

  bool sendAllLocalDataToAPi(
      {List<SalesData>? salesData,
      List<SalesLocationTrack>? locations,
      List<Retailer>? mewOutlets,
      Attendence? attendance,
      List<RequestDelivered>? requestedDelivered}) {
    bool allDataSend = true;

    //sales data
    if (salesData!.isNotEmpty) {
      useCaseForSalesDataImpl
          .saveSalesData(salesData)
          .then((value) => value.fold(
              (l) => {
                    allDataSend = false,
                  },
              (r) => {deleteSalesData()}));
    }

    if (mewOutlets!.isNotEmpty) {
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
    if (requestedDelivered != null && requestedDelivered.isNotEmpty) {
      useCaseForSalesDataImpl
          .saveDeliveredRequest(requestedDelivered)
          .then((value) => value.fold(
              (l) => {
                    allDataSend = false,
                  },
              (r) => deleteDeliveredOrders()));
    }

    if (locations != null) {
      var useCaseForSalesDataTrackCollectionImpl =
          getIt<UseCaseForSalesDataTrackCollectionImpl>();
      useCaseForSalesDataTrackCollectionImpl
          .saveSalesDataAndTrackCollection(locations)
          .then((value) => value.fold(
              (l) => {
                    allDataSend = false,
                  },
              (r) => deleteLocationData()));
      ;
    }
    return allDataSend;
  }

  getAllDatFromApiAndSend() async {
    bool? isThereLocalData = await dataChecker.getLocalDataChecker();
    if (isThereLocalData != null && isThereLocalData != false) {
      List<SalesData>? salesData;
      List<Retailer>? mewOutlets;
      Attendence? attendance;
      List<RequestDelivered>? requestedDelivered;
      List<SalesLocationTrack> salesDataTrack;

      salesData = await getSalesData();
      mewOutlets = await getNewRetailers();
      attendance = await getAttendanceDataFromHiveBox();
      requestedDelivered = await getDeliveredOrderFromHive();
      salesDataTrack = await getSalesTrackDataFromHive();

      bool allDataSend = sendAllLocalDataToAPi(
          salesData: salesData,
          locations: salesDataTrack,
          mewOutlets: mewOutlets,
          attendance: attendance,
          requestedDelivered: requestedDelivered);
      if (allDataSend) {
        dataChecker.setLocalDataChecker(false);
      } else {
        return;
      }
    } else {
      return;
    }
  }

  Future<List<Retailer>?> getNewRetailers() async {
    List<Retailer>? retailer = [];
    Box newRetailerBox = await Hive.openBox(HiveConstants.newRetailer);
    var successOrFailed =
        useCaseForHiveImpl.getAllValuesFromHiveBox(newRetailerBox);
    successOrFailed.fold(
        (l) => {print("retrieving retailers data failed")},
        (r) => {
              for (int i = 0; i < r.length; i++)
                {
                  retailer.add(r[i]),
                },
            });

    return retailer;
  }

  Future<List<SalesData>?> getSalesData() async {
    List<SalesData> salesData = [];
    Box salesBox = await Hive.openBox(HiveConstants.salesDataCollection);
    var successOrFailed = useCaseForHiveImpl.getAllValuesFromHiveBox(salesBox);
    successOrFailed.fold(
        (l) => {print("retrieving sales data failed")},
        (r) => {
              for (int i = 0; i < r.length; i++) {salesData.add(r[i])},
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
              {checkout = r},
            });
    return checkout;
  }

  Future<List<RequestDelivered>> getDeliveredOrderFromHive() async {
    List<RequestDelivered> requestDelivered = [];
    Box deliveredBox = await Hive.openBox(HiveConstants.depotProductRetailers);
    useCaseForHiveImpl
        .getValuesByKey(deliveredBox, HiveConstants.deliveredOrders)
        .fold(
            (l) => {print("getting delivered data from hive is failed")},
            (r) => {
                  for (RequestDelivered request in r)
                    {
                      requestDelivered.add(request),
                    }
                });
    return requestDelivered;
  }

  Future<List<SalesLocationTrack>> getSalesTrackDataFromHive() async {
    List<SalesLocationTrack> salesTrackLocation = [];
    Box locationBox;
    locationBox = await Hive.openBox(HiveConstants.salesPersonLocationTrack);
    useCaseForHiveImpl.getAllValuesFromHiveBox(locationBox).fold(
        (l) => {print("getting delivered data from hive is failed")},
        (r) => {
              for (SalesLocationTrack request in r)
                {
                  salesTrackLocation.add(request),
                }
            });
    return salesTrackLocation;
  }

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

  deleteDeliveredOrders() async {
    Box deliveredBox = await Hive.openBox(HiveConstants.depotProductRetailers);
    deliveredBox.delete(HiveConstants.deliveredOrders);
  }

  deleteLocationData() async {
    Box locationBox =
        await Hive.openBox(HiveConstants.salesPersonLocationTrack);
    locationBox.clear();
  }
}
