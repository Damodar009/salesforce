import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/SalesDataModel.dart';
import '../../error/failure.dart';
import '../../injectable.dart';
import '../entities/SalesData.dart';
import '../repositories/repository.dart';

abstract class UseCaseForSalesData {
  Future<Either<Failure, String?>> saveSalesData(
      List<SalesDataModel> salesDataModel);
}

@injectable
class UseCaseForSalesDataImpl implements UseCaseForSalesData {
  var salesDataRepository = getIt<SaveSalesDataRepository>();
  //UseCaseForSalesDataImpl();

  @override
  Future<Either<Failure, String?>> saveSalesData(
      List<SalesData> salesDataModel) async {
    return await salesDataRepository.saveSalesData(salesDataModel);
  }
}
