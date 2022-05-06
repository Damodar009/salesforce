import 'package:dartz/dartz.dart';
import 'package:salesforce/domain/entities/userData.dart';
import '../../error/failure.dart';
import '../entities/attendence.dart';
import '../entities/depotProductRetailer.dart';

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

  Future<dynamic> postToRemoteSource();
}

abstract class AttendenceRepository {
  Future<Either<Failure, Attendence>> saveAttendence(Attendence attendence);
}

abstract class SalesDataTrackCollectionRepository {
  Future<Either<Failure, Attendence>>
}
