import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:salesforce/domain/entities/depotProductRetailer.dart';
import 'package:salesforce/injectable.dart';
import 'package:salesforce/utils/app_colors.dart';
import 'package:salesforce/utils/macAddress.dart';
import '../../../domain/entities/attendence.dart';
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
    var failureOrSuccess = await useCaseForHiveImpl.getValueByKey(
        box, HiveConstants.attendenceCheckinKey);
    failureOrSuccess.fold(
        (l) => {
              print("getting attendance data from the hive is failed"),
            },
        (r) => {
              if (r != null)
                {
                  moonLanding = DateTime.parse(r.checkin!),
                  if (now.day == moonLanding.day) {isCheckIn = true}
                }
            });
    if (isCheckIn == true) {
      var failureOrSucess = useCaseForHiveImpl.getValueByKey(
          box, HiveConstants.attendenceCheckOutKey);
      failureOrSucess.fold(
          (l) => {print("data from checkout hive box is failed")},
          (r) => {
                print(r),
                if (r != null)
                  {
                    print("the checkout data is here"),
                    print(r),
                    moonLanding = DateTime.parse(r.checkout!),
                    if (now.day == moonLanding.day)
                      {
                        isCheckIn = false,
                      }
                  }
                else
                  {print("the attendence data is not passed")},
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
    int minimumDistance = 50; // in meters
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
    print("get depot list");
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
    print("saving data to the hive");
    Box box = await Hive.openBox(HiveConstants.attendence);

    if (isCheckIn) {
      //save data to api
      Attendence? attendenceCheckOut =
          box.get(HiveConstants.attendenceCheckOutKey);
      if (attendenceCheckOut != null) {
        attendance = attendance.copyWith(
          checkout_longitude: attendenceCheckOut.checkout_longitude,
          checkout_latitude: attendenceCheckOut.checkout_latitude,
          checkout: attendenceCheckOut.checkout,
        );
      }

      var successOrFailed =
          await useCaseForAttendenceImpl.attendenceSave(attendance);
      successOrFailed.fold(
          (l) => {
                print("saving check in attendance data to Api is failed"),
              },
          (r) async => {
                print("saving check in attendance data to Api is success"),
                if (box.containsKey(HiveConstants.attendenceCheckOutKey))
                  {box.delete(HiveConstants.attendenceCheckOutKey)},

                //save to hive
                useCaseForHiveImpl
                    .saveValueByKey(box, HiveConstants.attendenceCheckinKey, r)
                    .fold(
                        (l) => {print("saving check in to hive is failed")},
                        (r) => {
                              print("saving check in to hive is passed"),
                              isSaved = true,
                            }),
              });
    } else {
      print("this is inside checkout");
      bool internet = await InternetConnectionChecker().hasConnection;
      if (internet) {
        await useCaseForAttendenceImpl
            .attendenceSave(attendance)
            .then((value) => {
                  value.fold(
                      (l) => {},
                      (r) => {
                            isSaved = true,
                          })
                });
      } else {
        // var checklocalDataSend = getIt<SignInLocalDataSourceImpl>();
        // checklocalDataSend.setLocalDataChecker(true);
      }
      var successOrFailedApi = useCaseForHiveImpl.saveValueByKey(
          box, HiveConstants.attendenceCheckOutKey, attendance);
      successOrFailedApi.fold(
          (l) => {},
          (r) => {
                isSaved = true,
              });
    }
    print("this is the value of is saved without internet ");
    print(isSaved);
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
              print("getting depot from hive is failed")
              //todo hive failed
              //   emit(HiveSaveFailed()),
            },
        (r) =>
            {print("getting depot from hive is passed"), print(r), depots = r});

    return depots;
  }

  /// check in
  Future<bool> checkIn() async {
    //check today date with check in
    DateTime now = DateTime.now();
    bool checkedInBool = false;
    Attendence? checkInAttendance =
        await getAttendanceDataFromHiveBox(HiveConstants.attendenceCheckinKey);
    if ((checkInAttendance == null ||
        now.day != DateTime.parse(checkInAttendance.checkin!).day)) {
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
          print("you are inside depot");
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
          if (checkedIn) {
            emit(CheckedInState());
            checkedInBool = checkedIn;
          } else {
            checkedInBool = false;
          }
        } else {
          Fluttertoast.showToast(
              msg: "Please go to the depot.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: AppColors.primaryColor,
              textColor: Colors.white,
              fontSize: 16.0);
          checkedInBool = false;
        }
      }
    } else {
      Fluttertoast.showToast(
          msg: "you have already checked in for today",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return checkedInBool;
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
      print("the attendance is");
      print(checkInAttendance);

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
