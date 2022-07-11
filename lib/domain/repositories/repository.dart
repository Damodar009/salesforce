import 'package:dartz/dartz.dart';
import 'package:salesforce/data/models/SaveUserDetailsDataModel.dart';
import 'package:salesforce/domain/entities/publish_notification.dart';
import 'package:salesforce/domain/entities/retailerPojo.dart';
import 'package:salesforce/domain/entities/userData.dart';
import 'package:salesforce/domain/entities/userDetailsData.dart';
import '../../data/models/reportModel.dart';
import '../../error/failure.dart';
import '../entities/AttendendenceDashbard.dart';
import '../entities/Leave.dart';
import '../entities/SalesData.dart';
import '../entities/attendence.dart';
import '../entities/depotProductRetailer.dart';
import '../entities/requestDeliver.dart';
import '../entities/retailer.dart';
import '../entities/salesPerson.dart';
import '../entities/saleslocationTrack.dart';

abstract class Repository {
  Future<Either<Failure, UserData>> login(String username, String password);
  Future<Either<Failure, String>> changePassword(
      String oldPassword, String newPassword);

  Future<Either<Failure, DepotProductRetailer>>
      getDepotProductRetailerDropDown();
  Future<Either<Failure, List<RetailerPojo>>> saveAllRetailer(
      List<Retailer> listOfRetailers);

  Future<Either<Failure, UserDetailsData>> getUserDetailsData();

  Future<Either<Failure, SaveUserDetailsDataModel>> saveUserDetails(
      SaveUserDetailsDataModel saveUserDetailsDataModel);
  Future<Either<Failure, String>> requestLeave(Leave leave);
  Future<Either<Failure, bool>> flagChecker();
}

abstract class AttendenceRepository {
  Future<Either<Failure, Attendence?>> saveAttendence(Attendence attendence);
  Future<Either<Failure, AttendanceDashboard?>> getDashBoardAttendance();
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
      List<SalesData> salesDataModel);
  Future<Either<Failure, String?>> saveDeliveredRequest(
      List<RequestDelivered> requestDelivered);
}

abstract class GetAllPublishNotificationRepository {
  Future<Either<Failure, List<PublishNotification>>>
      getAllPublishNotification();
}

abstract class ReportRepository {
  Future<Either<Failure, List<ReportModel>?>> getReport();
}
