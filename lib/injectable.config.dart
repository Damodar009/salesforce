// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'data/datasource/remoteSource/attendenceSave.dart' as _i3;
import 'data/datasource/remoteSource/remotesource.dart' as _i6;
import 'data/repository/attendenceRepositoryImpl.dart' as _i5;
import 'data/repository/repositories_impl.dart' as _i7;
import 'domain/repositories/repository.dart' as _i4;
import 'domain/usecases/useCaseForAttebdenceSave.dart' as _i8;
import 'domain/usecases/usecasesForRemoteSource.dart'
    as _i9; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i8.UseCaseForAttendenceImpl>(() => _i8.UseCaseForAttendenceImpl(
      attendenceRepository: get<_i4.AttendenceRepository>()));
  gh.factory<_i9.UseCaseForRemoteSourceimpl>(
      () => _i9.UseCaseForRemoteSourceimpl(get<_i4.Repository>()));
  return get;
}
