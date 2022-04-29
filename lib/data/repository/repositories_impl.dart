import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/domain/entities/userData.dart';
import '../../domain/repositories/repository.dart';
import '../../error/failure.dart';
import '../datasource/remotesource.dart';

@Singleton(as: Repository)
class RepositoryImplementation implements Repository {
  final RemoteSource remoteSource;

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
}
