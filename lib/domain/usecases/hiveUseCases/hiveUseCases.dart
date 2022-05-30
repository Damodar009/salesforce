import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import '../../../error/failure.dart';

abstract class UseCaseForHive {
  Either<Failure, List<dynamic>> getAllValuesFromHiveBox(Box box);
  Either<Failure, List<dynamic>> getAllKeysFromTheHiveBox(Box box);
  Either<Failure, List<dynamic>> getValuesByKey(Box box, String key);
  Either<Failure, String?> getValueByKey(Box box, String key);
  Either<Failure, String> saveValuestoHiveBox(Box box, dynamic values);
  Either<Failure, String> saveValueByKey(Box box, String key, dynamic values);
}

@lazySingleton
class UseCaseForHiveImpl implements UseCaseForHive {
  @override
  Either<Failure, List<dynamic>> getAllKeysFromTheHiveBox(Box box) {
    try {
      return Right(box.keys.toList());
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, List<dynamic>> getAllValuesFromHiveBox(Box box) {
    try {
      return Right(box.values.toList());
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, List<dynamic>> getValuesByKey(Box box, String key) {
    try {
      List<dynamic> values = box.get(key);

      return Right(values);
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, String> saveValueByKey(Box box, String key, values) {
    try {
      box.put(key, values);

      return const Right("Sucess");
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, String> saveValuestoHiveBox(Box box, dynamic values) {
    try {
      box.add(values);

      return const Right("Success");
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, String?> getValueByKey(Box box, String key) {
    print("inside hive hello");
    try {
      dynamic values = box.get(key);

      return Right(values);
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }
}
