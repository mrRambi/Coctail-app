part of 'search_drink_cubit.dart';

@freezed
class SearchDrinkState with _$SearchDrinkState {
  const factory SearchDrinkState.searchedDrinkLoading() = _SearchedDrinkLoading;
  const factory SearchDrinkState.searchedDrinkLoadError(String message) =
      _SearchedDrinkLoadError;
  const factory SearchDrinkState.searchedDrinkLoadSuccess(List<Drink?>? data) =
      _SearchedDrinkLoadSuccess;
}
