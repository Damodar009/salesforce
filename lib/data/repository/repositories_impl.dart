import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/data/datasource/local_data_sources.dart';
import 'package:salesforce/data/models/SaveUserDetailsDataModel.dart';
import 'package:salesforce/data/models/Userdata.dart';
import 'package:salesforce/domain/entities/Leave.dart';
import 'package:salesforce/domain/entities/retailerPojo.dart';
import 'package:salesforce/domain/entities/userDetailsData.dart';
import 'package:salesforce/domain/usecases/hiveUseCases/hiveUseCases.dart';
import 'package:salesforce/injectable.dart';
import 'package:salesforce/utils/hiveConstant.dart';
import '../../domain/entities/depotProductRetailer.dart';
import '../../domain/entities/retailer.dart';
import '../../domain/repositories/repository.dart';
import '../../error/failure.dart';
import '../datasource/remoteSource/remotesource.dart';

@Injectable(as: Repository)
class RepositoryImplementation implements Repository {
  var remoteSource = getIt<RemoteSource>();
  var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();
  final signInLocalDataSource = getIt<SignInLocalDataSource>();

  RepositoryImplementation({required this.remoteSource});

  @override
  Future<Either<Failure, UserDataModel>> login(
      String username, String password) async {
    try {
      final user = await remoteSource.login(username, password);
      await signInLocalDataSource.saveUserDataToLocal(user);
      Box box = await Hive.openBox(HiveConstants.userData);
      box.put(HiveConstants.isLoggedIn, true);
      return Right(user);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> changePassword(
      String oldPassword, String newPassword) async {
    try {
      final response =
          await remoteSource.changePassword(oldPassword, newPassword);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, DepotProductRetailer>>
      getDepotProductRetailerDropDown() async {
    try {
      final response = await remoteSource.getDepotProductAndRetailer();
      return Right(response);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<RetailerPojo>>> saveAllRetailer(
      List<Retailer> listOfRetailers) async {
    try {
      final response = await remoteSource.saveAllRetailer(listOfRetailers);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserDetailsData>> getUserDetailsData() async {
    try {
      final response = await remoteSource.getUserDetailsData();
      return Right(response);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, SaveUserDetailsDataModel>> saveUserDetails(
    SaveUserDetailsDataModel saveUserDetailsDataModel,
  ) async {
    try {
      final response =
          await remoteSource.saveUserDetails(saveUserDetailsDataModel);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> requestLeave(Leave leave) async {
    try {
      final response = await remoteSource.requestLeave(leave);

      return Right(response);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> flagChecker() async {
    try {
      final response = await remoteSource.flagChecker();

      return Right(response);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
