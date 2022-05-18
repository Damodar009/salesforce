import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/data/models/SaveUserDetailsDataModel.dart';
import 'package:salesforce/domain/entities/retailerPojo.dart';
import 'package:salesforce/domain/entities/userData.dart';
import 'package:salesforce/domain/entities/userDetailsData.dart';
import 'package:salesforce/domain/usecases/hiveUseCases/hiveUseCases.dart';
import 'package:salesforce/injectable.dart';
import 'package:salesforce/utils/hiveConstant.dart';
import '../../domain/entities/depotProductRetailer.dart';
import '../../domain/repositories/repository.dart';
import '../../error/failure.dart';
import '../datasource/remoteSource/remotesource.dart';

@Injectable(as: Repository)
class RepositoryImplementation implements Repository {
  var remoteSource = getIt<RemoteSource>();
  var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();

  RepositoryImplementation({required this.remoteSource});

  @override
  Future<Either<Failure, UserData>> login(
      String username, String password) async {
    try {
      final question = await remoteSource.login(username, password);

      print('you are inside repository impl');

      Box box = await Hive.openBox(HiveConstants.userdata);

      useCaseForHiveImpl.saveValueByKey(
          box, "access_token", question.access_token);
      useCaseForHiveImpl.saveValueByKey(
          box, "access_token", question.access_token);
      useCaseForHiveImpl.saveValueByKey(
          box, "refresh_token", question.refresh_token);
      useCaseForHiveImpl.saveValueByKey(box, "expires_in", question.expires_in);
      useCaseForHiveImpl.saveValueByKey(box, "role", question.role);
      useCaseForHiveImpl.saveValueByKey(box, "full_name", question.full_name);
      useCaseForHiveImpl.saveValueByKey(box, "userid", question.userid);
      useCaseForHiveImpl.saveValueByKey(box, "name", question.name);
      useCaseForHiveImpl.saveValueByKey(box, "token_type", question.token_type);

      String access_token =
          useCaseForHiveImpl.getValueByKey(box, "access_token").toString();

      print(" this is access_token hahhah $access_token");

      return Right(question);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, dynamic>> postToRemoteSource() async {
    try {
      final response = await remoteSource.postDataToApi();
      return Right(response);
    } catch (e) {
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
  Future<Either<Failure, String>> postImage() async {
    try {
      final response = await remoteSource.postImage();
      return Right(response);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> attendenceSave() async {
    try {
      final response = await remoteSource.attendenceSave();
      return Right(response);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getProductList() async {
    try {
      final response = await remoteSource.getProductList();
      return Right(response);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getRegionList() async {
    try {
      final response = await remoteSource.getRegionList();
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
      List<RetailerPojo> listOfRetailers) async {
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
      print('hello hello hello hello');
      final response = await remoteSource.getUserDetailsData();

      // Box box = await Hive.openBox(HiveConstants.userdata);

      // useCaseForHiveImpl.saveValueByKey(box, "roleId", response.roleId);
      // useCaseForHiveImpl.saveValueByKey(
      //     box, "user_detail_id", response.userDetail!.user_detail_id);

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

      print('whatr is this beavior');

      return Right(response);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  // @override
  // Future<Either<Failure, SalesDataCollection>> saveSalesDataCollection() async {
  //   try {
  //     final response = await remoteSource.saveSalesDataCollection();
  //     return Right(response);
  //   } catch (e) {
  //     return Left(ServerFailure());
  //   }
  // }
}
