import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/reportModel.dart';
import '../../data/repository/reportRepositoryImpl.dart';
import '../../error/failure.dart';
import '../../injectable.dart';

abstract class UseCaseForReport {
  Future<Either<Failure, List<ReportModel>?>> getReport();
}

@injectable
class UseCaseForReportImpl implements UseCaseForReport {
  var reportRepository = getIt<ReportRepositoryImpl>();
  UseCaseForReportImpl({required this.reportRepository});

  @override
  Future<Either<Failure, List<ReportModel>?>> getReport() {
    return reportRepository.getReport();
  }
}
