import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recipe_app/data/repositories/drink_repository.dart';

import '../../../../data/repositories/models/drinks_model/drinks_data.dart';

part 'display_favorite_list_state.dart';
part 'display_favorite_list_cubit.freezed.dart';

class DisplayFavoriteListCubit extends Cubit<DisplayFavoriteListState> {
  DisplayFavoriteListCubit(this._drinkRepo)
      : super(const DisplayFavoriteListState.favoriteToDisplayLoading());

  final DrinkRepository _drinkRepo;

  Future<void> fetchFavoriteDrink(String drinkId) async {
    emit(const DisplayFavoriteListState.favoriteToDisplayLoading());
    try {
      final data = await _drinkRepo.fetchSpecificDrink(drinkId);
      emit(DisplayFavoriteListState.favoriteToDisplaySuccess(data!));
    } catch (e) {
      emit(DisplayFavoriteListState.favoriteToDisplayFailure(e.toString()));
    }
  }
}
