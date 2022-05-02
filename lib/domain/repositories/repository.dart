import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/domain/entities/userData.dart';
import '../../error/failure.dart';

abstract class Repository {
  Future<Either<Failure, UserData>> login(String username, String password);
  Future<Either<Failure, String>> changePassword(String oldPassword, String newPassword);
  Future<Either<Failure, String>> postImage();
  Future<Either<Failure, String>> getProductList();
  Future<Either<Failure, String>> getRegionList();
  Future<Either<Failure, String>> attendenceSave();

  Future<dynamic> postToRemoteSource();
}
