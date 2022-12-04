import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recipe_app/data/repositories/drink_repository.dart';

import '../../../data/repositories/models/drinks_model/drink.dart';

part 'drink_state.dart';
part 'drink_cubit.freezed.dart';

class DrinkCubit extends Cubit<DrinkState> {
  DrinkCubit(this._drinkRepo) : super(const DrinkState.drinkLoading());
  final DrinkRepository _drinkRepo;

  Future<void> fetchDrinks() async {
    emit(const DrinkState.drinkLoading());
    try {
      final data = await _drinkRepo.fetchTopTenDrinks();
      emit(DrinkState.drinkLoadSuccess(data));
    } catch (e) {
      emit(DrinkState.drinkLoadFailure(e.toString()));
    }
  }
}
