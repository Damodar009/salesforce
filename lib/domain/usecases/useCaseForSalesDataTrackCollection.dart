import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../error/failure.dart';
import '../../injectable.dart';
import '../entities/saleslocationTrack.dart';
import '../repositories/repository.dart';

abstract class UseCaseForSalesDataTrackCollection {
  Future<Either<Failure, List<SalesLocationTrack>>>
      saveSalesDataAndTrackCollection(
          List<SalesLocationTrack> listSalesLocationTrack);
}

@injectable
class UseCaseForSalesDataTrackCollectionImpl
    implements UseCaseForSalesDataTrackCollection {
  var salesDataCollectionRepository =
      getIt<SalesDataTrackCollectionRepository>();
  UseCaseForSalesDataTrackCollectionImpl(
      {required this.salesDataCollectionRepository});

  @override
  Future<Either<Failure, List<SalesLocationTrack>>>
      saveSalesDataAndTrackCollection(
          List<SalesLocationTrack> listSalesLocationTrack) async {
    return await salesDataCollectionRepository
        .saveSalesDataAndTrackCollection(listSalesLocationTrack);
  }
}
