import 'package:background_location/background_location.dart';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/utils/AapiUtils.dart';
import '../../error/failure.dart';
import '../../injectable.dart';
import '../../utils/hiveConstant.dart';
import '../entities/saleslocationTrack.dart';
import '../repositories/repository.dart';

abstract class UseCaseForSalesDataTrackCollection {
  Future<Either<Failure, List<SalesLocationTrack>>>
      saveSalesDataAndTrackCollection(
          List<SalesLocationTrack> listSalesLocationTrack);
  saveSalesTrackDataTOHive(double distanceFilter);
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

  @override
  saveSalesTrackDataTOHive(double distanceFilter) async {
    await BackgroundLocation.setAndroidNotification(
      title: 'Background service is running',
      message: 'Background location in progress',
      icon: '@mipmap/ic_launcher',
    );
    DateTime dateTime = DateTime.now();
    Box locationBox;
    locationBox = await Hive.openBox(HiveConstants.salesPersonLocationTrack);
    AppInterceptors appInterceptors = AppInterceptors();
    String? userId = await appInterceptors.getUserId();
    if (userId != null) {
      SalesLocationTrack salesLocationTrack = SalesLocationTrack(
          trackingDate: "${dateTime.year}-${dateTime.month}-${dateTime.day}",
          longitude: 1,
          latitude: 1,
          userId: '');

      await BackgroundLocation.setAndroidConfiguration(3000);
      await BackgroundLocation.startLocationService(
          distanceFilter: distanceFilter);

      BackgroundLocation.getLocationUpdates((location) {
        SalesLocationTrack salesLocationTracks = salesLocationTrack.copyWith(
            latitude: location.latitude!, longitude: location.longitude!);

        locationBox.add(salesLocationTracks);
        print("location is updating regularly ");
        print(location.latitude);
        print(location.longitude);
      });
    }
  }
}
