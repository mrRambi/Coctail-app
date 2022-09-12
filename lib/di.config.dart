// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i5;
import 'package:injectable/injectable.dart' as _i2;

import 'data/remote_data_sources/current_user_repo.dart' as _i6;
import 'data/remote_data_sources/drink_api.dart' as _i8;
import 'data/remote_data_sources/firebase_repo.dart' as _i3;
import 'data/remote_data_sources/firestore_repo.dart' as _i7;
import 'data/repositories/drink_repository.dart' as _i10;
import 'data/service/drink_service.dart'
    as _i9; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AuthenticationRepository>(() => _i3.AuthenticationRepository(
      firebaseAuth: get<_i4.FirebaseAuth>(),
      googleSignIn: get<_i5.GoogleSignIn>()));
  gh.factory<_i6.CurrentUserRepo>(() =>
      _i6.CurrentUserRepo(dataFireStoreRepo: get<_i7.DataFireStoreRepo>()));
  gh.factory<_i7.DataFireStoreRepo>(() => _i7.DataFireStoreRepo());
  gh.factory<_i8.DrinkApi>(() => _i8.DrinkApi());
  gh.factory<_i9.DrinkService>(
      () => _i9.DrinkService(drinkApi: get<_i8.DrinkApi>()));
  gh.factory<_i10.DrinkRepository>(
      () => _i10.DrinkRepository(drinkService: get<_i9.DrinkService>()));
  return get;
}
