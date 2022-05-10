import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/domain/entities/retailerPojo.dart';
import 'package:salesforce/domain/entities/salesPerson.dart';
import 'package:salesforce/domain/entities/userDetail.dart';
import 'package:salesforce/domain/entities/userDetailsData.dart';
import 'package:salesforce/injectable.dart';
import '../../error/failure.dart';
import '../entities/depotProductRetailer.dart';
import '../entities/userData.dart';
import '../repositories/repository.dart';

abstract class UseCaseForRemoteSource {
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

  Future<Either<Failure, SalesPerson>> saveUserDetails(SalesPerson salesPerson, UserDetails userDetails);

  // Future<Either<Failure, SalesDataCollection>> saveSalesDataCollection();

  Future<Either<Failure, dynamic>> postToRemoteSource();
}

@injectable
class UseCaseForRemoteSourceimpl implements UseCaseForRemoteSource {
  var repository = getIt<Repository>();
  UseCaseForRemoteSourceimpl(this.repository) {
    print("the usecase for remote soure impl is created ");
  }

  @override
  Future<Either<Failure, UserData>> login(
      String username, String password) async {
    return await repository.login(username, password);
  }

  @override
  Future<Either<Failure, dynamic>> postToRemoteSource() async {
    return await repository.postToRemoteSource();
  }

  @override
  Future<Either<Failure, String>> changePassword(
      String oldPassword, String newPassword) async {
    return await repository.changePassword(oldPassword, newPassword);
  }

  @override
  Future<Either<Failure, String>> postImage() async {
    return await repository.postImage();
  }

  @override
  Future<Either<Failure, String>> attendenceSave() async {
    return await repository.attendenceSave();
  }

  @override
  Future<Either<Failure, String>> getProductList() async {
    return await repository.getProductList();
  }

  @override
  Future<Either<Failure, String>> getRegionList() async {
    return await repository.getRegionList();
  }

  @override
  Future<Either<Failure, DepotProductRetailer>>
      getDepotProductRetailerDropDown() async {
    return await repository.getDepotProductRetailerDropDown();
  }

  @override
  Future<Either<Failure, List<RetailerPojo>>> saveAllRetailer(
      List<RetailerPojo> listOfRetailers) async {
    return await repository.saveAllRetailer(listOfRetailers);
  }

  @override
  Future<Either<Failure, UserDetailsData>> getUserDetailsData() async {
    return await repository.getUserDetailsData();
  }

  @override
  Future<Either<Failure, SalesPerson>> saveUserDetails(
      SalesPerson salesPerson, UserDetails userDetails) async {
    return await repository.saveUserDetails(salesPerson, userDetails);
  }

  // @override
  // Future<Either<Failure, SalesDataCollection>> saveSalesDataCollection() async {
  //   return await repository.saveSalesDataCollection();
  // }
}
