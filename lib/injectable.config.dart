// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'data/datasource/local_data_sources.dart' as _i20;
import 'data/datasource/remoteSource/attendenceSave.dart' as _i4;
import 'data/datasource/remoteSource/get_all_publish_notification_remote_data_source.dart'
    as _i8;
import 'data/datasource/remoteSource/remotesource.dart' as _i10;
import 'data/datasource/remoteSource/report.dart' as _i11;
import 'data/datasource/remoteSource/salesDataAndTrackCollection.dart' as _i14;
import 'data/datasource/remoteSource/salesDataRemoteSource.dart' as _i15;
import 'data/datasource/remoteSource/salesTeam.dart' as _i17;
import 'data/datasource/remoteSource/upload_image_remote_data_source.dart'
    as _i22;
import 'data/repository/attendenceRepositoryImpl.dart' as _i6;
import 'data/repository/get_all_publish_notification_repository_impl.dart'
    as _i9;
import 'data/repository/reportRepositoryImpl.dart' as _i12;
import 'data/repository/repositories_impl.dart' as _i13;
import 'data/repository/salesDataAndTrackCollectionRepositoryImpl.dart' as _i16;
import 'data/repository/salesPersonRepositoryImpl.dart' as _i18;
import 'data/repository/SaveSalesDataRepositoryImpl.dart' as _i19;
import 'data/repository/uploading_image_repository_impl.dart' as _i23;
import 'domain/repositories/repository.dart' as _i5;
import 'domain/usecases/hiveUseCases/hiveUseCases.dart' as _i25;
import 'domain/usecases/useCaseForAttebdenceSave.dart' as _i24;
import 'domain/usecases/useCaseForReport.dart' as _i27;
import 'domain/usecases/useCaseForSalesData.dart' as _i28;
import 'domain/usecases/useCaseForSalesDataTrackCollection.dart' as _i29;
import 'domain/usecases/useCaseForSalesPerson.dart' as _i30;
import 'domain/usecases/usecasesForRemoteSource.dart' as _i26;
import 'domain/usecases/useCaseTosendAllLocalData.dart' as _i3;
import 'domain/usecases/usercase_for_publish_notification.dart' as _i21;
import 'domain/usecases/userCaseForUploadImageSave.dart' as _i31;
import 'utils/geolocation.dart' as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AllLocalDataToApi>(() => _i3.AllLocalDataToApi());
  gh.factory<_i4.AttendenceRemoteSource>(() => _i4.AttendenceSave());
  gh.factory<_i5.AttendenceRepository>(() => _i6.AttendenceRepositoryImpl(
      attendenceRemoteSource: get<_i4.AttendenceRemoteSource>()));
  gh.singleton<_i7.GeoLocationData>(_i7.GeoLocationData());
  gh.factory<_i8.GetAllPublishNotificationRemoteDataSource>(
      () => _i8.GetAllPublishNotificationRemoteDataSourceImpl());
  gh.factory<_i5.GetAllPublishNotificationRepository>(
      () => _i9.GetAllPublishNotificationRepositoryImpl());
  gh.factory<_i10.RemoteSource>(() => _i10.RemoteSourceImplementation());
  gh.factory<_i11.ReportRemoteSource>(() => _i11.ReportRemoteSourceImpl());
  gh.factory<_i5.ReportRepository>(() => _i12.ReportRepositoryImpl(
      reportRemoteSource: get<_i11.ReportRemoteSource>()));
  gh.factory<_i5.Repository>(() =>
      _i13.RepositoryImplementation(remoteSource: get<_i10.RemoteSource>()));
  gh.factory<_i14.SalesDataAndTrackCollectionRemoteSource>(
      () => _i14.SalesDataAndTrackCollectionRemoteSourceimpl());
  gh.factory<_i15.SalesDataRemoteSource>(
      () => _i15.SalesDataRemoteSourceImpl());
  gh.factory<_i5.SalesDataTrackCollectionRepository>(() =>
      _i16.SalesDataTrackCollectionRepositotyImpl(
          salesDataAndTrackCollectionRemoteSource:
              get<_i14.SalesDataAndTrackCollectionRemoteSource>()));
  gh.factory<_i17.SalesTeamRemoteSource>(
      () => _i17.SalesTeamRemoteSourceImpl());
  gh.factory<_i5.SalesTeamRepository>(() => _i18.SalesTeamRepositoryImpl(
      salesPersonRemoteSource: get<_i17.SalesTeamRemoteSource>()));
  gh.factory<_i5.SaveSalesDataRepository>(() =>
      _i19.SaveSalesDataRepositoryImpl(
          salesDataRemoteSource: get<_i15.SalesDataRemoteSource>()));
  gh.factory<_i20.SignInLocalDataSource>(
      () => _i20.SignInLocalDataSourceImpl());
  gh.factory<_i21.UUseCaseForPublishNotificationImpl>(
      () => _i21.UUseCaseForPublishNotificationImpl());
  gh.factory<_i22.UploadImageRemoteDataSource>(
      () => _i22.UploadImageRemoteDataSourceImpl());
  gh.factory<_i5.UploadImageRepository>(() => _i23.UploadImageRepositoryImpl());
  gh.factory<_i24.UseCaseForAttendenceImpl>(() => _i24.UseCaseForAttendenceImpl(
      attendenceRepository: get<_i5.AttendenceRepository>()));
  gh.lazySingleton<_i25.UseCaseForHiveImpl>(() => _i25.UseCaseForHiveImpl());
  gh.factory<_i26.UseCaseForRemoteSourceimpl>(
      () => _i26.UseCaseForRemoteSourceimpl(get<_i5.Repository>()));
  gh.factory<_i27.UseCaseForReportImpl>(() =>
      _i27.UseCaseForReportImpl(reportRepository: get<_i5.ReportRepository>()));
  gh.factory<_i28.UseCaseForSalesDataImpl>(
      () => _i28.UseCaseForSalesDataImpl());
  gh.factory<_i29.UseCaseForSalesDataTrackCollectionImpl>(() =>
      _i29.UseCaseForSalesDataTrackCollectionImpl(
          salesDataCollectionRepository:
              get<_i5.SalesDataTrackCollectionRepository>()));
  gh.factory<_i30.UseCaseForSalesPersonImpl>(() =>
      _i30.UseCaseForSalesPersonImpl(
          salesTeamRepository: get<_i5.SalesTeamRepository>()));
  gh.factory<_i31.UseCaseForUploadImageImpl>(
      () => _i31.UseCaseForUploadImageImpl());
  return get;
}
