import 'package:dartz/dartz.dart';
import 'package:salesforce/data/models/SaveUserDetailsDataModel.dart';
import 'package:salesforce/domain/entities/retailerPojo.dart';
import 'package:salesforce/domain/entities/userData.dart';
import 'package:salesforce/domain/entities/userDetailsData.dart';
import '../../data/models/SalesDataModel.dart';
import '../../error/failure.dart';
import '../entities/attendence.dart';
import '../entities/depotProductRetailer.dart';
import '../entities/salesPerson.dart';
import '../entities/saleslocationTrack.dart';

abstract class Repository {
  Future<Either<Failure, UserData>> login(String username, String password);
  Future<Either<Failure, String>> changePassword(
      String oldPassword, String newPassword);
  Future<Either<Failure, String>> postImage();
  Future<Either<Failure, String>> getProductList();
  Future<Either<Failure, String>> getRegionList();
  Future<Either<Failure, String>> attendenceSave();
  Future<Either<Failure, DepotProductRetailer>>
      getDepotProductRetailerDropDown();
  Future<Either<Failure, List<RetailerPojo>>> saveAllRetailer(
      List<RetailerPojo> listOfRetailers);

  Future<Either<Failure, UserDetailsData>> getUserDetailsData();

  Future<Either<Failure, SaveUserDetailsDataModel>> saveUserDetails(
      SaveUserDetailsDataModel saveUserDetailsDataModel);

  // Future<Either<Failure, SalesDataCollection>> saveSalesDataCollection();

  Future<dynamic> postToRemoteSource();
}

abstract class AttendenceRepository {
  Future<Either<Failure, Attendence>> saveAttendence(Attendence attendence);
}

abstract class SalesDataTrackCollectionRepository {
  Future<Either<Failure, List<SalesLocationTrack>>>
      saveSalesDataAndTrackCollection(
          List<SalesLocationTrack> listSalesLocationTrack);
}

abstract class SalesTeamRepository {
  Future<Either<Failure, SalesPerson>> saveSalesPerson(SalesPerson salesPerson);
}

abstract class UploadImageRepository {
  Future<Either<Failure, String>> uploadImageSave(String imageName);
}

abstract class SaveSalesDataRepository {
  Future<Either<Failure, String?>> saveSalesData(
      List<SalesDataModel> salesDataModel);
}
