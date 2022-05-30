// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i17;

import 'data/datasource/local_data_sources.dart' as _i18;
import 'data/datasource/remoteSource/attendenceSave.dart' as _i3;
import 'data/datasource/remoteSource/get_all_publish_notification_remote_data_source.dart'
    as _i7;
import 'data/datasource/remoteSource/remotesource.dart' as _i9;
import 'data/datasource/remoteSource/salesDataAndTrackCollection.dart' as _i11;
import 'data/datasource/remoteSource/salesDataRemoteSource.dart' as _i12;
import 'data/datasource/remoteSource/salesTeam.dart' as _i14;
import 'data/datasource/remoteSource/upload_image_remote_data_source.dart'
    as _i20;
import 'data/repository/attendenceRepositoryImpl.dart' as _i5;
import 'data/repository/get_all_publish_notification_repository_impl.dart'
    as _i8;
import 'data/repository/repositories_impl.dart' as _i10;
import 'data/repository/salesDataAndTrackCollectionRepositoryImpl.dart' as _i13;
import 'data/repository/salesPersonRepositoryImpl.dart' as _i15;
import 'data/repository/SaveSalesDataRepositoryImpl.dart' as _i16;
import 'data/repository/uploading_image_repository_impl.dart' as _i21;
import 'domain/repositories/repository.dart' as _i4;
import 'domain/usecases/hiveUseCases/hiveUseCases.dart' as _i23;
import 'domain/usecases/useCaseForAttebdenceSave.dart' as _i22;
import 'domain/usecases/useCaseForSalesData.dart' as _i25;
import 'domain/usecases/useCaseForSalesDataTrackCollection.dart' as _i26;
import 'domain/usecases/useCaseForSalesPerson.dart' as _i27;
import 'domain/usecases/usecasesForRemoteSource.dart' as _i24;
import 'domain/usecases/usercase_for_publish_notification.dart' as _i19;
import 'domain/usecases/userCaseForUploadImageSave.dart' as _i28;
import 'utils/geolocation.dart' as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final injectionModule = _$InjectionModule();
  gh.factory<_i3.AttendenceRemoteSource>(() => _i3.AttendenceSave());
  gh.factory<_i4.AttendenceRepository>(() => _i5.AttendenceRepositoryImpl(
      attendenceRemoteSource: get<_i3.AttendenceRemoteSource>()));
  gh.singleton<_i6.GeoLocationData>(_i6.GeoLocationData());
  gh.factory<_i7.GetAllPublishNotificationRemoteDataSource>(
      () => _i7.GetAllPublishNotificationRemoteDataSourceImpl());
  gh.factory<_i4.GetAllPublishNotificationRepository>(
      () => _i8.GetAllPublishNotificationRepositoryImpl());
  gh.factory<_i9.RemoteSource>(() => _i9.RemoteSourceImplementation());
  gh.factory<_i4.Repository>(() =>
      _i10.RepositoryImplementation(remoteSource: get<_i9.RemoteSource>()));
  gh.factory<_i11.SalesDataAndTrackCollectionRemoteSource>(
      () => _i11.SalesDataAndTrackCollectionRemoteSourceimpl());
  gh.factory<_i12.SalesDataRemoteSource>(
      () => _i12.SalesDataRemoteSourceImpl());
  gh.factory<_i4.SalesDataTrackCollectionRepository>(() =>
      _i13.SalesDataTrackCollectionRepositotyImpl(
          salesDataAndTrackCollectionRemoteSource:
              get<_i11.SalesDataAndTrackCollectionRemoteSource>()));
  gh.factory<_i14.SalesTeamRemoteSource>(
      () => _i14.SalesTeamRemoteSourceImpl());
  gh.factory<_i4.SalesTeamRepository>(() => _i15.SalesTeamRepositoryImpl(
      salesPersonRemoteSource: get<_i14.SalesTeamRemoteSource>()));
  gh.factory<_i4.SaveSalesDataRepository>(() =>
      _i16.SaveSalesDataRepositoryImpl(
          salesDataRemoteSource: get<_i12.SalesDataRemoteSource>()));
  await gh.factoryAsync<_i17.SharedPreferences>(() => injectionModule.prefs,
      preResolve: true);
  gh.factory<_i18.SignInLocalDataSource>(
      () => _i18.SignInLocalDataSourceImpl());
  gh.factory<_i19.UUseCaseForPublishNotificationImpl>(
      () => _i19.UUseCaseForPublishNotificationImpl());
  gh.factory<_i20.UploadImageRemoteDataSource>(
      () => _i20.UploadImageRemoteDataSourceImpl());
  gh.factory<_i4.UploadImageRepository>(() => _i21.UploadImageRepositoryImpl());
  gh.factory<_i22.UseCaseForAttendenceImpl>(() => _i22.UseCaseForAttendenceImpl(
      attendenceRepository: get<_i4.AttendenceRepository>()));
  gh.lazySingleton<_i23.UseCaseForHiveImpl>(() => _i23.UseCaseForHiveImpl());
  gh.factory<_i24.UseCaseForRemoteSourceimpl>(
      () => _i24.UseCaseForRemoteSourceimpl(get<_i4.Repository>()));
  gh.factory<_i25.UseCaseForSalesDataImpl>(() => _i25.UseCaseForSalesDataImpl(
      salesDataRepository: get<_i4.SaveSalesDataRepository>()));
  gh.factory<_i26.UseCaseForSalesDataTrackCollectionImpl>(() =>
      _i26.UseCaseForSalesDataTrackCollectionImpl(
          salesDataCollectionRepository:
              get<_i4.SalesDataTrackCollectionRepository>()));
  gh.factory<_i27.UseCaseForSalesPersonImpl>(() =>
      _i27.UseCaseForSalesPersonImpl(
          salesTeamRepository: get<_i4.SalesTeamRepository>()));
  gh.factory<_i28.UseCaseForUploadImageImpl>(
      () => _i28.UseCaseForUploadImageImpl());
  return get;
}

class _$InjectionModule extends _i18.InjectionModule {}
