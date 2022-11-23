import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recipe_app/data/remote_data_sources/current_user_repo.dart';

part 'favorite_drink_of_user_state.dart';
part 'favorite_drink_of_user_cubit.freezed.dart';

class FavoriteDrinkOfUserCubit extends Cubit<FavoriteDrinkOfUserState> {
  FavoriteDrinkOfUserCubit(this._currentUserRepo)
      : super(const FavoriteDrinkOfUserState.favoriteLoading());

  final CurrentUserRepo _currentUserRepo;

  Future<void> addFavorite(String id) async {
    emit(const FavoriteDrinkOfUserState.favoriteLoading());
    try {
      final data = await _currentUserRepo.addFavoriteDrinkToUser(id);

      emit(FavoriteDrinkOfUserState.favoriteLoadSuccess(data));
    } catch (e) {
      emit(FavoriteDrinkOfUserState.favoriteLoadError(e.toString()));
    }
  }

  Future<void> removeFavorite(String id) async {
    emit(const FavoriteDrinkOfUserState.favoriteLoading());
    try {
      final data = await _currentUserRepo.removeFavoriteDrinkToUser(id);
      emit(FavoriteDrinkOfUserState.favoriteLoadSuccess(data));
    } catch (e) {
      emit(FavoriteDrinkOfUserState.favoriteLoadError(e.toString()));
    }
  }

  Future<void> readFavorite() async {
    emit(const FavoriteDrinkOfUserState.favoriteLoading());
    try {
      final data = await _currentUserRepo.readUser();
      emit(FavoriteDrinkOfUserState.favoriteLoadSuccess([data]));
    } catch (e) {
      emit(FavoriteDrinkOfUserState.favoriteLoadError(e.toString()));
    }
  }
}
