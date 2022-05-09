import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/domain/entities/salesPerson.dart';
import '../../error/failure.dart';
import '../../injectable.dart';
import '../repositories/repository.dart';

abstract class UseCaseForSalesPerson {
  Future<Either<Failure, SalesPerson>> saveSalesPerson(SalesPerson salesPerson);
}

@injectable
class UseCaseForSalesPersonImpl implements UseCaseForSalesPerson {
  var salesTeamRepository = getIt<SalesTeamRepository>();
  UseCaseForSalesPersonImpl({required this.salesTeamRepository});

  @override
  Future<Either<Failure, SalesPerson>> saveSalesPerson(
      SalesPerson salesPerson) async {
    return await salesTeamRepository.saveSalesPerson(salesPerson);
  }
}
