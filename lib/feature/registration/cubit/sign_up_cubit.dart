import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recipe_app/data/remote_data_sources/current_user_repo.dart';
import 'package:recipe_app/data/repositories/models/app_user.dart';

import '../../../data/remote_data_sources/firebase_repo.dart';
import '../../../data/repositories/models/email.dart';
import '../../../data/repositories/models/password.dart';

part 'sign_up_state.dart';
part 'sign_up_cubit.freezed.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authenticationRepository, this._currentUserRepo)
      : super(
          const SignUpState(
              email: Email.pure(),
              password: Password.pure(),
              status: FormzStatus.pure),
        );
  final AuthenticationRepository _authenticationRepository;
  final CurrentUserRepo _currentUserRepo;

  void emailChanged(String value) {
    final email = Email.dirty(value: value);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([
          email,
          state.password,
        ]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value: value);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([
          state.email,
          password,
        ]),
      ),
    );
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final data = await _authenticationRepository.signUp(
        email: state.email.value,
        password: state.password.value,
      );
      if (data.user?.uid == null) return;
      final appUserData = AppUser(
          email: data.user?.email ?? '',
          id: data.user!.uid,
          favoriteDrinks: []);

      _currentUserRepo.creatUser(appUserData);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
