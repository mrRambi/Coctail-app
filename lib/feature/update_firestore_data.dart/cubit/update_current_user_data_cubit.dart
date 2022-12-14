import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/remote_data_sources/current_user_repo.dart';

part 'update_current_user_data_state.dart';
part 'update_current_user_data_cubit.freezed.dart';

class UpdateCurrentUserDataCubit extends Cubit<UpdateCurrentUserDataState> {
  UpdateCurrentUserDataCubit(this._currentUserRepo)
      : super(const UpdateCurrentUserDataState.currentUserDataLoading());

  final CurrentUserRepo _currentUserRepo;

  Future<void> readUserColection() async {
    // emit(const UpdateCurrentUserDataState.currentUserDataLoading());
    try {
      final data = await _currentUserRepo.readUserToStringList();

      emit(UpdateCurrentUserDataState.currentUserDataLoadSuccess(data));
    } catch (e) {
      emit(UpdateCurrentUserDataState.currentUserDataError(e.toString()));
    }
  }

  Future<void> addFavorite(String id) async {
    // emit(const UpdateCurrentUserDataState.currentUserDataLoading());
    try {
      final data = await _currentUserRepo.addFavoriteDrinkToUser(id);

      emit(UpdateCurrentUserDataState.currentUserDataLoadSuccess(data));
    } catch (e) {
      emit(UpdateCurrentUserDataState.currentUserDataError(e.toString()));
    }
  }

  Future<void> removeFavorite(String id) async {
    // emit(const UpdateCurrentUserDataState.currentUserDataLoading());
    try {
      final data = await _currentUserRepo.removeFavoriteDrinkToUser(id);
      emit(UpdateCurrentUserDataState.currentUserDataLoadSuccess(data));
    } catch (e) {
      emit(UpdateCurrentUserDataState.currentUserDataError(e.toString()));
    }
  }
}
