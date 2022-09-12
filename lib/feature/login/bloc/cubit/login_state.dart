part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    required FormzStatus status,
    required Password password,
    required Email email,
    String? errorMessage,
  }) = _LoginState;
}
