// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'data/datasource/remoteSource/attendenceSave.dart' as _i3;
import 'data/datasource/remoteSource/remotesource.dart' as _i6;
import 'data/datasource/remoteSource/salesDataAndTrackCollection.dart' as _i8;
import 'data/datasource/remoteSource/salesTeam.dart' as _i10;
import 'data/repository/attendenceRepositoryImpl.dart' as _i5;
import 'data/repository/repositories_impl.dart' as _i7;
import 'data/repository/salesDataAndTrackCollectionRepositoryImpl.dart' as _i9;
import 'data/repository/salesPersonRepositoryImpl.dart' as _i11;
import 'domain/repositories/repository.dart' as _i4;
import 'domain/usecases/useCaseForAttebdenceSave.dart' as _i12;
import 'domain/usecases/useCaseForSalesDataTrackCollection.dart' as _i14;
import 'domain/usecases/useCaseForSalesPerson.dart' as _i15;
import 'domain/usecases/usecasesForRemoteSource.dart'
    as _i13; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AttendenceRemoteSource>(() => _i3.AttendenceSave());
  gh.factory<_i4.AttendenceRepository>(() => _i5.AttendenceRepositoryImpl(
      attendenceRemoteSource: get<_i3.AttendenceRemoteSource>()));
  gh.factory<_i6.RemoteSource>(() => _i6.RemoteSourceImplementation());
  gh.factory<_i4.Repository>(() =>
      _i7.RepositoryImplementation(remoteSource: get<_i6.RemoteSource>()));
  gh.factory<_i8.SalesDataAndTrackCollectionRemoteSource>(
      () => _i8.SalesDataAndTrackCollectionRemoteSourceimpl());
  gh.factory<_i4.SalesDataTrackCollectionRepository>(() =>
      _i9.SalesDataTrackCollectionRepositotyImpl(
          salesDataAndTrackCollectionRemoteSource:
              get<_i8.SalesDataAndTrackCollectionRemoteSource>()));
  gh.factory<_i10.SalesTeamRemoteSource>(
      () => _i10.SalesTeamRemoteSourceImpl());
  gh.factory<_i4.SalesTeamRepository>(() => _i11.SalesTeamRepositoryImpl(
      salesPersonRemoteSource: get<_i10.SalesTeamRemoteSource>()));
  gh.factory<_i12.UseCaseForAttendenceImpl>(() => _i12.UseCaseForAttendenceImpl(
      attendenceRepository: get<_i4.AttendenceRepository>()));
  gh.factory<_i13.UseCaseForRemoteSourceimpl>(
      () => _i13.UseCaseForRemoteSourceimpl(get<_i4.Repository>()));
  gh.factory<_i14.UseCaseForSalesDataTrackCollectionImpl>(() =>
      _i14.UseCaseForSalesDataTrackCollectionImpl(
          salesDataCollectionRepository:
              get<_i4.SalesDataTrackCollectionRepository>()));
  gh.factory<_i15.UseCaseForSalesPersonImpl>(() =>
      _i15.UseCaseForSalesPersonImpl(
          salesTeamRepository: get<_i4.SalesTeamRepository>()));
  return get;
}
