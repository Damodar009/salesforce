import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/reportModel.dart';
import '../../error/failure.dart';
import '../../injectable.dart';
import '../repositories/repository.dart';

abstract class UseCaseForReport {
  Future<Either<Failure, List<ReportModel>?>> getReport();
}

@injectable
class UseCaseForReportImpl implements UseCaseForReport {
  var reportRepository = getIt<ReportRepository>();
  UseCaseForReportImpl({required this.reportRepository});

  @override
  Future<Either<Failure, List<ReportModel>?>> getReport() {
    return reportRepository.getReport();
  }
}
