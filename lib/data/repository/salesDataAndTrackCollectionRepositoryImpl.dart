import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/saleslocationTrack.dart';
import '../../domain/repositories/repository.dart';
import '../../error/failure.dart';
import '../../injectable.dart';
import '../datasource/remoteSource/salesDataAndTrackCollection.dart';

@Injectable(as: SalesDataTrackCollectionRepository)
class SalesDataTrackCollectionRepositotyImpl
    implements SalesDataTrackCollectionRepository {
  var salesDataAndTrackCollectionRemoteSource =
      getIt<SalesDataAndTrackCollectionRemoteSource>();
  SalesDataTrackCollectionRepositotyImpl(
      {required this.salesDataAndTrackCollectionRemoteSource});

  @override
  Future<Either<Failure, List<SalesLocationTrack>>>
      saveSalesDataAndTrackCollection(
          List<SalesLocationTrack> listSalesLocationTrack) async {
    try {
      final question = await salesDataAndTrackCollectionRemoteSource
          .saveSalesDataAndTrackCollection(listSalesLocationTrack);
      return Right(question);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
