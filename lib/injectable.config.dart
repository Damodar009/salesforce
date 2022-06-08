// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i15;

import 'data/datasource/local_data_sources.dart' as _i16;
import 'data/datasource/remoteSource/attendenceSave.dart' as _i3;
import 'data/datasource/remoteSource/remotesource.dart' as _i7;
import 'data/datasource/remoteSource/salesDataAndTrackCollection.dart' as _i9;
import 'data/datasource/remoteSource/salesDataRemoteSource.dart' as _i10;
import 'data/datasource/remoteSource/salesTeam.dart' as _i12;
import 'data/datasource/remoteSource/upload_image_remote_data_source.dart'
    as _i17;
import 'data/repository/attendenceRepositoryImpl.dart' as _i5;
import 'data/repository/repositories_impl.dart' as _i8;
import 'data/repository/salesDataAndTrackCollectionRepositoryImpl.dart' as _i11;
import 'data/repository/salesPersonRepositoryImpl.dart' as _i13;
import 'data/repository/SaveSalesDataRepositoryImpl.dart' as _i14;
import 'data/repository/uploading_image_repository_impl.dart' as _i18;
import 'domain/repositories/repository.dart' as _i4;
import 'domain/usecases/hiveUseCases/hiveUseCases.dart' as _i20;
import 'domain/usecases/useCaseForAttebdenceSave.dart' as _i19;
import 'domain/usecases/useCaseForSalesData.dart' as _i22;
import 'domain/usecases/useCaseForSalesDataTrackCollection.dart' as _i23;
import 'domain/usecases/useCaseForSalesPerson.dart' as _i24;
import 'domain/usecases/usecasesForRemoteSource.dart' as _i21;
import 'domain/usecases/userCaseForUploadImageSave.dart' as _i25;
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
  gh.factory<_i7.RemoteSource>(() => _i7.RemoteSourceImplementation());
  gh.factory<_i4.Repository>(() =>
      _i8.RepositoryImplementation(remoteSource: get<_i7.RemoteSource>()));
  gh.factory<_i9.SalesDataAndTrackCollectionRemoteSource>(
      () => _i9.SalesDataAndTrackCollectionRemoteSourceimpl());
  gh.factory<_i10.SalesDataRemoteSource>(
      () => _i10.SalesDataRemoteSourceImpl());
  gh.factory<_i4.SalesDataTrackCollectionRepository>(() =>
      _i11.SalesDataTrackCollectionRepositotyImpl(
          salesDataAndTrackCollectionRemoteSource:
              get<_i9.SalesDataAndTrackCollectionRemoteSource>()));
  gh.factory<_i12.SalesTeamRemoteSource>(
      () => _i12.SalesTeamRemoteSourceImpl());
  gh.factory<_i4.SalesTeamRepository>(() => _i13.SalesTeamRepositoryImpl(
      salesPersonRemoteSource: get<_i12.SalesTeamRemoteSource>()));
  gh.factory<_i4.SaveSalesDataRepository>(() =>
      _i14.SaveSalesDataRepositoryImpl(
          salesDataRemoteSource: get<_i10.SalesDataRemoteSource>()));
  await gh.factoryAsync<_i15.SharedPreferences>(() => injectionModule.prefs,
      preResolve: true);
  gh.factory<_i16.SignInLocalDataSource>(
      () => _i16.SignInLocalDataSourceImpl());
  gh.factory<_i17.UploadImageRemoteDataSource>(
      () => _i17.UploadImageRemoteDataSourceImpl());
  gh.factory<_i4.UploadImageRepository>(() => _i18.UploadImageRepositoryImpl());
  gh.factory<_i19.UseCaseForAttendenceImpl>(() => _i19.UseCaseForAttendenceImpl(
      attendenceRepository: get<_i4.AttendenceRepository>()));
  gh.lazySingleton<_i20.UseCaseForHiveImpl>(() => _i20.UseCaseForHiveImpl());
  gh.factory<_i21.UseCaseForRemoteSourceimpl>(
      () => _i21.UseCaseForRemoteSourceimpl(get<_i4.Repository>()));
  gh.factory<_i22.UseCaseForSalesDataImpl>(
      () => _i22.UseCaseForSalesDataImpl());
  gh.factory<_i23.UseCaseForSalesDataTrackCollectionImpl>(() =>
      _i23.UseCaseForSalesDataTrackCollectionImpl(
          salesDataCollectionRepository:
              get<_i4.SalesDataTrackCollectionRepository>()));
  gh.factory<_i24.UseCaseForSalesPersonImpl>(() =>
      _i24.UseCaseForSalesPersonImpl(
          salesTeamRepository: get<_i4.SalesTeamRepository>()));
  gh.factory<_i25.UseCaseForUploadImageImpl>(
      () => _i25.UseCaseForUploadImageImpl());
  return get;
}

class _$InjectionModule extends _i16.InjectionModule {}
