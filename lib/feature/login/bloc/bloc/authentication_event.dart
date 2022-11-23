part of 'authentication_bloc.dart';

@freezed
class AuthenticationEvent with _$AuthenticationEvent {
  const factory AuthenticationEvent.userChanged(AppUser? user) = _UserChanged;
  const factory AuthenticationEvent.logoutRequested() = _LogoutRequested;
}
