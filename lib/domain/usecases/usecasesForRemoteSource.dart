import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/data/models/SaveUserDetailsDataModel.dart';
import 'package:salesforce/domain/entities/retailerPojo.dart';
import 'package:salesforce/domain/entities/userDetailsData.dart';
import 'package:salesforce/injectable.dart';

import '../../error/failure.dart';
import '../entities/depotProductRetailer.dart';
import '../entities/retailer.dart';
import '../entities/userData.dart';
import '../repositories/repository.dart';

abstract class UseCaseForRemoteSource {
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

  // Future<Either<Failure, UserDetailsData>> saveUserDetails();

}

@injectable
class UseCaseForRemoteSourceimpl implements UseCaseForRemoteSource {
  var repository = getIt<Repository>();
  UseCaseForRemoteSourceimpl(this.repository);

  @override
  Future<Either<Failure, UserData>> login(
      String username, String password) async {
    return await repository.login(username, password);
  }

  @override
  Future<Either<Failure, String>> changePassword(
      String oldPassword, String newPassword) async {
    return await repository.changePassword(oldPassword, newPassword);
  }

  // @override
  // Future<Either<Failure, String>> attendenceSave() async {
  //   return await repository.attendenceSave();
  // }

  @override
  Future<Either<Failure, DepotProductRetailer>>
      getDepotProductRetailerDropDown() async {
    return await repository.getDepotProductRetailerDropDown();
  }

  @override
  Future<Either<Failure, List<RetailerPojo>>> saveAllRetailer(
      List<Retailer> listOfRetailers) async {
    return await repository.saveAllRetailer(listOfRetailers);
  }

  @override
  Future<Either<Failure, UserDetailsData>> getUserDetailsData() async {
    return await repository.getUserDetailsData();
  }

  @override
  Future<Either<Failure, SaveUserDetailsDataModel>> saveUserDetails(
      SaveUserDetailsDataModel saveUserDetailsDataModel) async {
    return await repository.saveUserDetails(saveUserDetailsDataModel);
  }

  // @override
  // Future<Either<Failure, SalesDataCollection>> saveSalesDataCollection() async {
  //   return await repository.saveSalesDataCollection();
  // }
}
