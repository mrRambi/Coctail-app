// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i5;
import 'package:injectable/injectable.dart' as _i2;

import 'data/remote_data_sources/current_user_repo.dart' as _i9;
import 'data/remote_data_sources/drink_api.dart' as _i7;
import 'data/remote_data_sources/firebase_repo.dart' as _i3;
import 'data/remote_data_sources/firestore_repo.dart' as _i6;
import 'data/repositories/drink_repository.dart' as _i10;
import 'data/repositories/search_repo.dart' as _i11;
import 'data/service/drink_service.dart'
    as _i8; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i3.AuthenticationRepository>(() => _i3.AuthenticationRepository(
        firebaseAuth: get<_i4.FirebaseAuth>(),
        googleSignIn: get<_i5.GoogleSignIn>(),
      ));
  gh.factory<_i6.DataFireStoreRepo>(() => _i6.DataFireStoreRepo());
  gh.factory<_i7.DrinkApi>(() => _i7.DrinkApi());
  gh.singleton<_i8.DrinkService>(
      _i8.DrinkService(drinkApi: get<_i7.DrinkApi>()));
  gh.factory<_i3.LogInWithEmailAndPasswordFailure>(
      () => _i3.LogInWithEmailAndPasswordFailure(get<String>()));
  gh.factory<_i3.LogInWithGoogleFailure>(
      () => _i3.LogInWithGoogleFailure(get<String>()));
  gh.factory<_i3.LogOutFailure>(() => _i3.LogOutFailure());
  gh.factory<_i3.SignUpWithEmailAndPasswordFailure>(
      () => _i3.SignUpWithEmailAndPasswordFailure(get<String>()));
  gh.factory<_i9.CurrentUserRepo>(() => _i9.CurrentUserRepo(
        get<_i8.DrinkService>(),
        dataFireStoreRepo: get<_i6.DataFireStoreRepo>(),
      ));
  gh.factory<_i10.DrinkRepository>(
      () => _i10.DrinkRepository(drinkService: get<_i8.DrinkService>()));
  gh.factory<_i11.SearchRepo>(
      () => _i11.SearchRepo(drinkRepository: get<_i10.DrinkRepository>()));
  return get;
}
