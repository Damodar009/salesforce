import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/SalesData.dart';
import '../../domain/repositories/repository.dart';
import '../../error/failure.dart';
import '../../injectable.dart';
import '../datasource/remoteSource/salesDataRemoteSource.dart';

@Injectable(as: SaveSalesDataRepository)
class SaveSalesDataRepositoryImpl implements SaveSalesDataRepository {
  var salesDataRemoteSource = getIt<SalesDataRemoteSource>();
  SaveSalesDataRepositoryImpl({required this.salesDataRemoteSource});

  @override
  Future<Either<Failure, String?>> saveSalesData(
      List<SalesData> salesDataModel) async {
    try {
      final question =
          await salesDataRemoteSource.saveSalesData(salesDataModel);
      return Right(question);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  // @override
  // Future<Either<Failure, String>> saveAttendence(
  //     Attendence attendence) async {
  //   try {
  //     final question = await attendenceRemoteSource.saveAttendence(attendence);
  //     return Right(question);
  //   } catch (e) {
  //     return Left(ServerFailure());
  //   }
  // }
}
