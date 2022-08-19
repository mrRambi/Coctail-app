// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'data/remote_data_sources/drink_api.dart' as _i3;
import 'data/repositories/drink_repository.dart' as _i5;
import 'data/service/drink_service.dart'
    as _i4; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.DrinkApi>(() => _i3.DrinkApi());
  gh.factory<_i4.DrinkService>(
      () => _i4.DrinkService(drinkApi: get<_i3.DrinkApi>()));
  gh.factory<_i5.DrinkRepository>(
      () => _i5.DrinkRepository(drinkService: get<_i4.DrinkService>()));
  return get;
}
