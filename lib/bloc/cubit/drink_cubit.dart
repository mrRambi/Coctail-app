import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../repository/drink_repo.dart';
import '../../repository/models/drinks_data/drinks_data.dart';

part 'drink_state.dart';
part 'drink_cubit.freezed.dart';

class DrinkCubit extends Cubit<DrinkState> {
  DrinkCubit(this._drinkRepo) : super(const DrinkState.drinkLoading());
  final DrinkRepo _drinkRepo;

  Future<void> fetchDrinks() async {
    emit(const DrinkState.drinkLoading());
    try {
      final data = await _drinkRepo.fetchDrinkFromSever();
      emit(DrinkState.drinkLoadSuccess(data!));
    } catch (e) {
      emit(DrinkState.drinkLoadFailure(e.toString()));
    }
  }
}
