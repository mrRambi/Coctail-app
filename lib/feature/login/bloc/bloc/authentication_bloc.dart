import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/remote_data_sources/firebase_repo.dart';
import '../../../../data/repositories/models/app_user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';
part 'authentication_bloc.freezed.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(this._authenticationRepository)
      : super(const AuthenticationState.unknown()) {
    on<AuthenticationEvent>(_onEvent);
    userSubscription = _authenticationRepository.user.listen(
      (user) => add(AuthenticationEvent.userChanged(user)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<AppUser?> userSubscription;
  late final StreamController<AppUser?> userController;

  void _onEvent(
    AuthenticationEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    await event.map(userChanged: (event) async {
      emit(event.user == null
          ? const AuthenticationState.unauthenticated()
          : AuthenticationState.authenticated(event.user!));
    }, logoutRequested: (event) async {
      unawaited(_authenticationRepository.logOut());
    });
  }

  void logOutUser() {
    _authenticationRepository.logOut();
  }

  Stream<AppUser?> isLoged() {
    return _authenticationRepository.user;
  }

  @override
  Future<void> close() {
    userSubscription.cancel();
    return super.close();
  }
}
