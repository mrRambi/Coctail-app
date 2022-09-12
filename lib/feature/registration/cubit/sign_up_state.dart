part of 'sign_up_cubit.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState({
    required FormzStatus status,
    required Password password,
    required Email email,
    String? errorMessage,
  }) = _SignUpState;
}
