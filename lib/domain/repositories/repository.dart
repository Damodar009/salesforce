import 'package:dartz/dartz.dart';
import 'package:salesforce/domain/entities/userData.dart';
import '../../error/failure.dart';

abstract class Repository {
  Future<Either<Failure, UserData>> login(String username, String password);
  Future<Either<Failure, String>> changePassword(String oldPassword, String newPassword);
  Future<Either<Failure, UserData>> resetPassword();
  Future<dynamic> postToRemoteSource();
}
