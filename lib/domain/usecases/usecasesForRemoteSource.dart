import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../error/failure.dart';
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

  Future<Either<Failure, dynamic>> postToRemoteSource();
}

@Singleton(as: UseCaseForRemoteSource)
class UseCaseForRemoteSourceimpl implements UseCaseForRemoteSource {
  final Repository repository;
  UseCaseForRemoteSourceimpl(this.repository);

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
}
