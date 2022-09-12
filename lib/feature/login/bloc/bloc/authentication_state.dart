part of 'authentication_bloc.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.unknown() = _Unknown;
  const factory AuthenticationState.authenticated(AppUser user) =
      _Authenticated;
  const factory AuthenticationState.unauthenticated() = _Unauthenticated;
}
