import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:salesforce/domain/entities/depotProductRetailer.dart';
import 'package:salesforce/injectable.dart';
import 'package:salesforce/utils/macAddress.dart';
import '../../../domain/entities/attendence.dart';
import 'package:geolocator/geolocator.dart';
import '../../../domain/usecases/hiveUseCases/hiveUseCases.dart';
import '../../../domain/usecases/useCaseForAttebdenceSave.dart';
import '../../../domain/usecases/usecasesForRemoteSource.dart';
import '../../../utils/geolocation.dart';
import '../../../utils/hiveConstant.dart';
part 'attendence_state.dart';

class AttendenceCubit extends Cubit<AttendenceState> {
  var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();
  var useCaseForAttendenceImpl = getIt<UseCaseForAttendenceImpl>();
  var useCaseForRemoteSourceimpl = getIt<UseCaseForRemoteSourceimpl>();
  var geolocator = getIt<GeoLocationData>();

  AttendenceCubit(this.useCaseForAttendenceImpl) : super(AttendenceInitial());

  /// getiing user id from hive box
  Future<String> getUserIdFromHiveBox() async {
    String userId = "";
    Box box = await Hive.openBox(HiveConstants.userdata);
    var failureOrSuccess = useCaseForHiveImpl.getValueByKey(box, "userid");
    failureOrSuccess.fold((l) => {emit(UserGetFailed())}, (r) => {userId = r!});

    return userId;
  }

  /// get data from the api
  Future<DepotProductRetailer?> getDepotAndDropDownFromApi() async {
    DepotProductRetailer? depotProdeuctRetailer;
    var failureOrsucess =
        await useCaseForRemoteSourceimpl.getDepotProductRetailerDropDown();
    failureOrsucess.fold(
        (l) => {
              emit(ApiFailed()),
            },
        (r) => {depotProdeuctRetailer = r});

    return depotProdeuctRetailer;
  }

  /// check current location with deppot list location
  Future<bool> checkCurrentLocationWithDepots(
      List<dynamic> depots, double latitude, double longitude) async {
    bool isIndepot = false;
    int minimunDistance = 20; // in meters
    var p = 0.017453292519943295;
    var c = cos;

    for (var i = 0; i < depots.length; i++) {
      double latitude2 = depots[i].latitude;
      double longitude2 = depots[i].longitude;

      var a = 0.5 -
          c((latitude - latitude2) * p) / 2 +
          c(latitude * p) *
              c(latitude2 * p) *
              (1 - c((longitude - longitude2) * p)) /
              2;

      print(12742 * asin(sqrt(a)));
      if (12742 * asin(sqrt(a)) <= minimunDistance) {
        isIndepot = true;

        Box box = await Hive.openBox(HiveConstants.attendence);
        var failureOrsucess = useCaseForHiveImpl.saveValueByKey(
            box, HiveConstants.assignedDepot, [latitude2, longitude2]);

        break;
      } else {}
    }
    return isIndepot;
  }

  /// get the depot list
  Future<List<dynamic>?> getDepotList() async {
    List<dynamic>? depots = await getDepotFromHive();
    if (depots != null) {
      return depots;
    } else {
      DepotProductRetailer? depotProductRetailer =
          await getDepotAndDropDownFromApi();
      if (depotProductRetailer != null) {
        depots = depotProductRetailer.depots;
        savedepotProductRetailerDropDownToHiveBox(depotProductRetailer);
      } else {
        return null;
      }
    }
    return depots;
  }

  /// look for the internet
  checkInternet() {}

  /// save attendence to api or local database
  saveDataToApiOrHive(Attendence attendence, isCheckIn) async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result) {
      var failureOrsucess =
          await useCaseForAttendenceImpl.attendenceSave(attendence);

      failureOrsucess.fold(
          (l) => {
                // if (l is ServerFailure)
                //   emit(AttendenceFailed())
                // else if (l is CacheFailure)
                //   emit(AttendenceFailed())
              },
          (r) => {}

          //emit(AttendenceSucess())
          );
    } else {
      if (!isCheckIn) {
        Box box = await Hive.openBox(HiveConstants.attendence);
        var failureOrsucess = useCaseForHiveImpl.saveValueByKey(
            box, HiveConstants.attendenceCheckOutKey, attendence);

        failureOrsucess.fold(
            (l) => {
                  // if (l is ServerFailure)
                  //   emit(AttendenceFailed())
                  // else if (l is CacheFailure)
                  //   emit(AttendenceFailed())
                },
            (r) => {
                  // if (r.toString() == "Success")
                  //   //emit(AttendenceSucess())
                  // else
                  //   emit(AttendenceFailed())
                });
      } else {
        emit(AttendenceFailed());
      }
    }
  }

  /// check for checkout data while check in
  dynamic getCheckoutDataFromHiveBox() async {
    dynamic checkout;
    Box box = await Hive.openBox(HiveConstants.attendence);
    var failureOrSucess = useCaseForHiveImpl.getValuesByKey(
        box, HiveConstants.attendenceCheckOutKey);

    failureOrSucess.fold(
        (l) => {
              // emit(AttendenceFailed())
            },
        (r) => {
              checkout = r,
            });

    return checkout;
  }

  ///  /// save depot and  dropdown to the hive box
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
      emit(HiveSaveFailed());
    }
  }

  /// get list of depot from the hive
  Future<List<dynamic>?> getDepotFromHive() async {
    List<dynamic>? depots;
    Box box = await Hive.openBox(HiveConstants.depotProductRetailers);
    var failureOrSuccess =
        useCaseForHiveImpl.getValuesByKey(box, HiveConstants.depotKey);

    failureOrSuccess.fold(
        (l) => {
              //todo hive failed
              emit(HiveSaveFailed()),
            },
        (r) => {depots = r});

    return depots;
  }

  /// check in
  Future<bool> checkIn() async {
    bool isInternet;
    bool failed = false;

    //emit(AttendenceLoading());
    // todo check for internet
    Position? position = await geolocator.getCurrentLocation();
    List<dynamic>? depots = await getDepotList();
    if (position != null && depots != null) {
      bool isInDepot = await checkCurrentLocationWithDepots(
          depots, position.latitude, position.longitude);

      if (isInDepot) {
        print(true);
        MacAddress macAddress = MacAddress();
        String dateTime = DateTime.now().toString();
        String macAddresss = await macAddress.getMacAddress();
        String userId = await getUserIdFromHiveBox();
        Attendence checkInAttendence = Attendence(null, macAddresss, dateTime,
            position.latitude, position.longitude, null, null, null, userId);

        saveDataToApiOrHive(checkInAttendence, true);
        //  emit(AttendenceSucess());
      } else {
        failed = true;
      }
    }
    return failed;
  }

  checkOut() async {
    Position? position = await geolocator.getCurrentLocation();
    if (position != null) {
      MacAddress macAddress = MacAddress();
      String dateTime = DateTime.now().toString();
      String macAddresss = await macAddress.getMacAddress();
      String userId = await getUserIdFromHiveBox();
      Attendence checkInAttendence = Attendence(null, macAddresss, null, null,
          null, dateTime, position.latitude, position.longitude, userId);

      saveDataToApiOrHive(checkInAttendence, true);
      emit(AttendenceSucess());
    } else {
      emit(LocationGetFailed());
    }
  }
}
