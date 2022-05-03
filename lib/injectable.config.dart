// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'data/datasource/remotesource.dart' as _i3;
import 'data/repository/repositories_impl.dart' as _i5;
import 'domain/repositories/repository.dart' as _i4;
import 'domain/usecases/usecasesForRemoteSource.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.RemoteSource>(() => _i3.RemoteSourceImplementation());
  gh.factory<_i4.Repository>(() =>
      _i5.RepositoryImplementation(remoteSource: get<_i3.RemoteSource>()));
  gh.factory<_i6.UseCaseForRemoteSourceimpl>(
      () => _i6.UseCaseForRemoteSourceimpl(get<_i4.Repository>()));
  return get;
}
