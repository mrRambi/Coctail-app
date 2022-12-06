import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recipe_app/data/remote_data_sources/current_user_repo.dart';
import 'package:recipe_app/data/repositories/models/app_user.dart';
import '../../../../data/remote_data_sources/firebase_repo.dart';
import '../../../../data/repositories/models/email.dart';
import '../../../../data/repositories/models/password.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository, this.currentUserRepo)
      : super(const LoginState(
            email: Email.pure(),
            password: Password.pure(),
            status: FormzStatus.pure));

  final AuthenticationRepository _authenticationRepository;
  final CurrentUserRepo currentUserRepo;

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
        status: Formz.validate([state.email, password]),
      ),
    );
  }

  Future<void> logInWithCredentials() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.logInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      await currentUserRepo.readUserDocument();

      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on LogInWithEmailAndPasswordFailure {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future<void> logInWithGoogle() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.logInWithGoogle();
      var user = await currentUserRepo.readUserDocument();

      if (user == null) return;
      if (user['favoriteDrinks'] == null) {
        user['favoriteDrinks'] = [];
        final userData = AppUser.fromJson(user);
        currentUserRepo.creatUser(userData);
      } else {
        currentUserRepo.creatUser(AppUser.fromJson(user));
      }

      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on LogInWithGoogleFailure catch (e) {
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
