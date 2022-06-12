import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  AttendenceCubit() : super(AttendenceInitial());

  /// getiing user id from hive box
  Future<String> getUserIdFromHiveBox() async {
    String userId = "";
    Box box = await Hive.openBox(HiveConstants.userdata);
    var failureOrSuccess = useCaseForHiveImpl.getValueByKey(box, "userid");
    failureOrSuccess.fold((l) => {}, (r) => {userId = r!});

    return userId;
  }

  getCheckInStatus() async {
    bool isCheckIn = false;
    DateTime now = DateTime.now();
    DateTime moonLanding;

    Box box = await Hive.openBox(HiveConstants.attendence);
    print("the keys of attendance box are ");
    print(box.keys.toList());
    var failureOrSuccess = useCaseForHiveImpl.getValueByKey(
        box, HiveConstants.attendenceCheckinKey);
    failureOrSuccess.fold(
        (l) => {
              print("getting attendance data from the hive is failed"),
            },
        (r) => {
              print(r),
              moonLanding = DateTime.parse(r.checkin!),
              if (now.day == moonLanding.day)
                {isCheckIn = true, print("this is the check in greater ")}
              // r.map((e) => {
              //       moonLanding = DateTime.parse(e.checkin!),
              //       if (now.day == moonLanding.day)
              //         {
              //           isCheckIn = true,
              //         }
              //     }),
            });
    if (isCheckIn == true) {
      var failureOrSucess = useCaseForHiveImpl.getValuesByKey(
          box, HiveConstants.attendenceCheckinKey);
      failureOrSucess.fold(
          (l) => {print("data from checkout hive box is failed")},
          (r) => {
                print("data from hive attendance is passed"),
                r.map((e) => {
                      moonLanding = DateTime.parse(e.checkout!),
                      if (now.day == moonLanding.day)
                        {
                          isCheckIn = false,
                        }
                    }),
              });
    }
    if (isCheckIn == true) {
      emit(CheckedInState());
    } else {
      emit(CheckedOutState());
    }
  }

  /// get data from the api
  Future<DepotProductRetailer?> getDepotAndDropDownFromApi() async {
    DepotProductRetailer? depotProdeuctRetailer;
    var failureOrsucess =
        await useCaseForRemoteSourceimpl.getDepotProductRetailerDropDown();
    failureOrsucess.fold(
        (l) => {
              //  emit(ApiFailed()),
            },
        (r) => {depotProdeuctRetailer = r});

    return depotProdeuctRetailer;
  }

  /// check current location with depot list location
  Future<bool> checkCurrentLocationWithDepots(
      List<dynamic> depots, double latitude, double longitude) async {
    bool isIndepot = false;
    int minimumDistance = 20; // in meters
    var p = 0.017453292519943295;
    var c = cos;

    for (var i = 0; i < depots.length; i++) {
      print("the location of depots are ");
      print(depots[i].latitude);
      print(depots[i].longitude);
      double latitude2 = depots[i].latitude;
      double longitude2 = depots[i].longitude;

      var a = 0.5 -
          c((latitude - latitude2) * p) / 2 +
          c(latitude * p) *
              c(latitude2 * p) *
              (1 - c((longitude - longitude2) * p)) /
              2;

      if (12742 * asin(sqrt(a)) <= minimumDistance) {
        isIndepot = true;

        Box box = await Hive.openBox(HiveConstants.attendence);
        var failureOrsucess = useCaseForHiveImpl.saveValueByKey(
            box, HiveConstants.assignedDepot, depots[i].id);
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
        saveDepotProductRetailerDropDownToHiveBox(depotProductRetailer);
      } else {
        return null;
      }
    }
    return depots;
  }

  /// look for the internet
  checkInternet() {}

  Future<bool> saveDataToApiOrHive(
      Attendence attendance, bool isCheckIn) async {
    bool isSaved = false;
    Box box = await Hive.openBox(HiveConstants.attendence);

    if (isCheckIn) {
      //save data to api
      var successOrFailed =
          await useCaseForAttendenceImpl.attendenceSave(attendance);
      successOrFailed.fold(
          (l) => {
                print("saving check in attendance data to Api is failed"),
              },
          (r) async => {
                print("saving check in attendance data to Api is success"),
                //save to hive
                useCaseForHiveImpl
                    .saveValueByKey(box, HiveConstants.attendenceCheckinKey, r)
                    .fold(
                        (l) => {print("saving check in to hive is failed")},
                        (r) => {
                              isSaved = true,
                            }),

                //todo check for check out data anf send if available
              });
    } else {
      print("this is inside checkout");
      bool internet = await InternetConnectionChecker().hasConnection;
      if (internet) {
        await useCaseForAttendenceImpl
            .attendenceSave(attendance)
            .then((value) => {
                  value.fold(
                      (l) => {
                            // print("check out data is failed"),
                          },
                      (r) => {
                            isSaved = true,
                            // print("check out data is  passed"),
                            // emit(CheckedOutState()),
                          })
                });
      } else {
        print("there is no internet ");
        var successOrFailedApi = useCaseForHiveImpl.saveValueByKey(
            box, HiveConstants.attendenceCheckinKey, attendance);
        successOrFailedApi.fold(
            (l) => {
                  // print("saving check out attendance data to hive is failed"),
                },
            (r) => {
                  // print("saving check out attendance data to hive is success"),
                  isSaved = true,
                  //  emit(CheckedOutState())
                });
      }
    }
    // print("this is the value of is saved without internet ");
    // print(isSaved);
    return isSaved;
  }

  /// check for checkout data while check in
  Future<Attendence?> getAttendanceDataFromHiveBox(
      String attendanceType) async {
    Attendence? checkout;
    Box box = await Hive.openBox(HiveConstants.attendence);
    var failureOrSuccess =
        useCaseForHiveImpl.getValueByKey(box, attendanceType);

    failureOrSuccess.fold(
        (l) => {},
        (r) => {
              checkout = r,
            });
    return checkout;
  }

  ///  /// save depot and  dropdown to the hive box
  saveDepotProductRetailerDropDownToHiveBox(
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
      //    emit(HiveSaveFailed());
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
              //   emit(HiveSaveFailed()),
            },
        (r) => {depots = r});

    return depots;
  }

  /// check in
  Future<bool> checkIn() async {
    bool failed = false;
    Position? position = await geolocator.getCurrentLocation();
    List<dynamic>? depots = await getDepotList();
    if (position != null && depots != null) {
      bool isInDepot = await checkCurrentLocationWithDepots(
          depots, position.latitude, position.longitude);

      // if (Platform.isAndroid) {
      //   deviceData =
      //       _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      // } else if (Platform.isIOS) {
      //   deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);

      if (isInDepot) {
        print(true);
        MacAddress macAddress = MacAddress();
        String dateTime = DateTime.now().toString();
        String macAddresss = await macAddress.getMacAddress();
        String userId = await getUserIdFromHiveBox();
        Attendence checkInAttendance = Attendence(
            id: null,
            macAddress: macAddresss,
            checkin: dateTime,
            checkin_latitude: position.latitude,
            checkin_longitude: position.longitude,
            checkout: null,
            checkout_latitude: null,
            checkout_longitude: null,
            user: userId);

        bool checkedIn = await saveDataToApiOrHive(checkInAttendance, true);
        print("this is the value of checked in $checkedIn");
        if (checkedIn) {
          emit(CheckedInState());
          failed = !checkedIn;
        } else {
          failed = true;
          print("check in is not successful");
        }
      } else {
        failed = true;
      }
    }
    return failed;
  }

  checkOut() async {
    bool failed = false;
    Position? position = await geolocator.getCurrentLocation();
    if (position != null) {
      String? id;
      String? checkIn;
      double? latitude, longitude;
      MacAddress macAddress = MacAddress();
      String dateTime = DateTime.now().toString();
      String macAddresss = await macAddress.getMacAddress();
      String userId = await getUserIdFromHiveBox();

      Attendence? checkInAttendance = await getAttendanceDataFromHiveBox(
          HiveConstants.attendenceCheckinKey);

      if (checkInAttendance != null) {
        id = checkInAttendance.id;
        if (id == null) {
          checkIn = checkInAttendance.checkin;
          latitude = checkInAttendance.checkin_latitude;
          longitude = checkInAttendance.checkin_longitude;
        }
      } else {}

      Attendence checkOutAttendance = Attendence(
          id: id,
          macAddress: macAddresss,
          checkin: checkIn,
          checkin_latitude: latitude,
          checkin_longitude: longitude,
          checkout: dateTime,
          checkout_latitude: position.latitude,
          checkout_longitude: position.longitude,
          user: userId);
      // print("the attendance is");
      // print(checkInAttendance);

      bool checkedIn = await saveDataToApiOrHive(checkOutAttendance, false);
      //  print("the value of checkIn in check out is $checkedIn");
      if (checkedIn) {
        emit(CheckedOutState());
        failed = false;
      } else {
        failed = true;
        Fluttertoast.showToast(
            msg: "check out not complete",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      failed = true;
      Fluttertoast.showToast(
          msg: "Please do location on",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      // emit(LocationGetFailed());
    }
    return failed;
  }
}
