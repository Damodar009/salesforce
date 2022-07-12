import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/SalesDataModel.dart';
import '../../error/failure.dart';
import '../../injectable.dart';
import '../entities/SalesData.dart';
import '../entities/requestDeliver.dart';
import '../repositories/repository.dart';

abstract class UseCaseForSalesData {
  Future<Either<Failure, String?>> saveSalesData(
      List<SalesDataModel> salesDataModel);
  Future<Either<Failure, String?>> saveDeliveredRequest(
      List<RequestDelivered> requestDelivered);
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

  @override
  Future<Either<Failure, String?>> saveDeliveredRequest(
      List<RequestDelivered> requestDelivered) async {
    return await salesDataRepository.saveDeliveredRequest(requestDelivered);
  }
}
