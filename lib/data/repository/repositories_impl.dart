import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/domain/entities/retailerPojo.dart';
import 'package:salesforce/domain/entities/salesPerson.dart';
import 'package:salesforce/domain/entities/userData.dart';
import 'package:salesforce/domain/entities/userDetailsData.dart';
import 'package:salesforce/injectable.dart';
import '../../domain/entities/depotProductRetailer.dart';
import '../../domain/entities/userDetail.dart';
import '../../domain/repositories/repository.dart';
import '../../error/failure.dart';
import '../datasource/remoteSource/remotesource.dart';

@Injectable(as: Repository)
class RepositoryImplementation implements Repository {
  var remoteSource = getIt<RemoteSource>();

  RepositoryImplementation({required this.remoteSource});

  @override
  Future<Either<Failure, UserData>> login(
      String username, String password) async {
    try {
      final question = await remoteSource.login(username, password);
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
      final response = await remoteSource.getUserDetailsData();
      return Right(response);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserDetails>> saveUserDetails(UserDetails userDetails) async{
    try {
      final response = await remoteSource.saveUserDetails(userDetails);
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
