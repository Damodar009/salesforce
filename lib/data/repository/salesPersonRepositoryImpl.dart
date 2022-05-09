import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/domain/entities/salesPerson.dart';
import 'package:salesforce/error/failure.dart';

import '../../domain/repositories/repository.dart';
import '../../injectable.dart';
import '../datasource/remoteSource/salesTeam.dart';

@Injectable(as: SalesTeamRepository)
class SalesTeamRepositoryImpl implements SalesTeamRepository {
  var salesPersonRemoteSource = getIt<SalesTeamRemoteSource>();
  SalesTeamRepositoryImpl({required this.salesPersonRemoteSource});

  @override
  Future<Either<Failure, SalesPerson>> saveSalesPerson(
      SalesPerson salesPerson) async {
    try {
      final question =
          await salesPersonRemoteSource.saveSalesPerson(salesPerson);
      return Right(question);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
