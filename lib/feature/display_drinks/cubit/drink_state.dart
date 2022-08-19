part of 'drink_cubit.dart';

@freezed
class DrinkState with _$DrinkState {
  const factory DrinkState.drinkLoading() = _DrinkLoading;
  const factory DrinkState.drinkLoadFailure(String message) = _DrinkLoadFailure;
  const factory DrinkState.drinkLoadSuccess(DrinksData data) =
      _DrinkLoadSuccess;
}
