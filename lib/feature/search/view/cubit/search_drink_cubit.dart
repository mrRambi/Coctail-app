import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recipe_app/data/repositories/drink_repository.dart';

import '../../../../data/repositories/models/drinks_model/drink.dart';

part 'search_drink_state.dart';
part 'search_drink_cubit.freezed.dart';

class SearchDrinkCubit extends Cubit<SearchDrinkState> {
  SearchDrinkCubit(this._drinkRepository)
      : super(const SearchDrinkState.searchedDrinkLoading());

  final DrinkRepository _drinkRepository;

  Future<void> readFavorite(String nameOfDrink) async {
    try {
      final List<Drink?>? data =
          await _drinkRepository.searchDrinkByName(nameOfDrink);

      emit(SearchDrinkState.searchedDrinkLoadSuccess(data));
    } catch (e) {
      const String mess = 'Sorry';
      emit(const SearchDrinkState.searchedDrinkLoadError(mess));
    }
  }
}
