// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'data/remote_data_sources/current_user_repo.dart' as _i7;
import 'data/remote_data_sources/drink_api.dart' as _i5;
import 'data/remote_data_sources/firebase_repo.dart' as _i3;
import 'data/remote_data_sources/firestore_repo.dart' as _i4;
import 'data/repositories/drink_repository.dart' as _i8;
import 'data/repositories/search_repo.dart' as _i9;
import 'data/service/drink_service.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.AuthenticationRepository>(
      () => _i3.AuthenticationRepository());
  gh.factory<_i4.DataFireStoreRepo>(() => _i4.DataFireStoreRepo());
  gh.factory<_i5.DrinkApi>(() => _i5.DrinkApi());
  gh.singleton<_i6.DrinkService>(
      _i6.DrinkService(drinkApi: get<_i5.DrinkApi>()));
  gh.factory<_i3.LogInWithEmailAndPasswordFailure>(
      () => _i3.LogInWithEmailAndPasswordFailure(get<String>()));
  gh.factory<_i3.LogInWithGoogleFailure>(
      () => _i3.LogInWithGoogleFailure(get<String>()));
  gh.factory<_i3.LogOutFailure>(() => _i3.LogOutFailure());
  gh.factory<_i3.SignUpWithEmailAndPasswordFailure>(
      () => _i3.SignUpWithEmailAndPasswordFailure(get<String>()));
  gh.factory<_i7.CurrentUserRepo>(() => _i7.CurrentUserRepo(
        get<_i6.DrinkService>(),
        get<_i3.AuthenticationRepository>(),
        dataFireStoreRepo: get<_i4.DataFireStoreRepo>(),
      ));
  gh.factory<_i8.DrinkRepository>(
      () => _i8.DrinkRepository(drinkService: get<_i6.DrinkService>()));
  gh.factory<_i9.SearchRepo>(
      () => _i9.SearchRepo(drinkRepository: get<_i8.DrinkRepository>()));
  return get;
}
