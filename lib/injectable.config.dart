// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'data/datasource/remoteSource/attendenceSave.dart' as _i3;
import 'data/datasource/remoteSource/remotesource.dart' as _i7;
import 'data/datasource/remoteSource/salesDataAndTrackCollection.dart' as _i9;
import 'data/datasource/remoteSource/salesTeam.dart' as _i11;
import 'data/datasource/remoteSource/upload_image_remote_data_source.dart'
    as _i13;
import 'data/repository/attendenceRepositoryImpl.dart' as _i5;
import 'data/repository/repositories_impl.dart' as _i8;
import 'data/repository/salesDataAndTrackCollectionRepositoryImpl.dart' as _i10;
import 'data/repository/salesPersonRepositoryImpl.dart' as _i12;
import 'data/repository/uploading_image_repository_impl.dart' as _i14;
import 'domain/repositories/repository.dart' as _i4;
import 'domain/usecases/hiveUseCases/hiveUseCases.dart' as _i16;
import 'domain/usecases/userCaseForUploadImageSave.dart' as _i20;
import 'domain/usecases/useCaseForAttebdenceSave.dart' as _i15;
import 'domain/usecases/useCaseForSalesDataTrackCollection.dart' as _i18;
import 'domain/usecases/useCaseForSalesPerson.dart' as _i19;
import 'domain/usecases/usecasesForRemoteSource.dart' as _i17;
import 'utils/geolocation.dart' as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AttendenceRemoteSource>(() => _i3.AttendenceSave());
  gh.factory<_i4.AttendenceRepository>(() => _i5.AttendenceRepositoryImpl(
      attendenceRemoteSource: get<_i3.AttendenceRemoteSource>()));
  gh.singleton<_i6.GeoLocationData>(_i6.GeoLocationData());
  gh.factory<_i7.RemoteSource>(() => _i7.RemoteSourceImplementation());
  gh.factory<_i4.Repository>(() =>
      _i8.RepositoryImplementation(remoteSource: get<_i7.RemoteSource>()));
  gh.factory<_i9.SalesDataAndTrackCollectionRemoteSource>(
      () => _i9.SalesDataAndTrackCollectionRemoteSourceimpl());
  gh.factory<_i4.SalesDataTrackCollectionRepository>(() =>
      _i10.SalesDataTrackCollectionRepositotyImpl(
          salesDataAndTrackCollectionRemoteSource:
              get<_i9.SalesDataAndTrackCollectionRemoteSource>()));
  gh.factory<_i11.SalesTeamRemoteSource>(
      () => _i11.SalesTeamRemoteSourceImpl());
  gh.factory<_i4.SalesTeamRepository>(() => _i12.SalesTeamRepositoryImpl(
      salesPersonRemoteSource: get<_i11.SalesTeamRemoteSource>()));
  gh.factory<_i13.UploadImageRemoteDataSource>(
      () => _i13.UploadImageRemoteDataSourceImpl());
  gh.factory<_i4.UploadImageRepository>(() => _i14.UploadImageRepositoryImpl());
  gh.factory<_i15.UseCaseForAttendenceImpl>(() => _i15.UseCaseForAttendenceImpl(
      attendenceRepository: get<_i4.AttendenceRepository>()));
  gh.lazySingleton<_i16.UseCaseForHiveImpl>(() => _i16.UseCaseForHiveImpl());
  gh.factory<_i17.UseCaseForRemoteSourceimpl>(
      () => _i17.UseCaseForRemoteSourceimpl(get<_i4.Repository>()));
  gh.factory<_i18.UseCaseForSalesDataTrackCollectionImpl>(() =>
      _i18.UseCaseForSalesDataTrackCollectionImpl(
          salesDataCollectionRepository:
              get<_i4.SalesDataTrackCollectionRepository>()));
  gh.factory<_i19.UseCaseForSalesPersonImpl>(() =>
      _i19.UseCaseForSalesPersonImpl(
          salesTeamRepository: get<_i4.SalesTeamRepository>()));
  gh.factory<_i20.UseCaseForUploadImageImpl>(
      () => _i20.UseCaseForUploadImageImpl());
  return get;
}
