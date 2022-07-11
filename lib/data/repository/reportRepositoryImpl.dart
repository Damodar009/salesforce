import 'package:dartz/dartz.dart';
import 'package:salesforce/data/datasource/remoteSource/report.dart';
import 'package:salesforce/domain/repositories/repository.dart';
import 'package:salesforce/error/failure.dart';

import '../../injectable.dart';
import '../models/reportModel.dart';

class ReportRepositoryImpl implements ReportRepository {
  var reportRemoteSource = getIt<ReportRemoteSource>();
  ReportRepositoryImpl({required this.reportRemoteSource});
  @override
  Future<Either<Failure, List<ReportModel>?>> getReport() async {
    try {
      final report = await reportRemoteSource.getReport();
      return Right(report);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
