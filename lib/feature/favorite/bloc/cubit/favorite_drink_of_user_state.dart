part of 'favorite_drink_of_user_cubit.dart';

@freezed
class FavoriteDrinkOfUserState with _$FavoriteDrinkOfUserState {
  const factory FavoriteDrinkOfUserState.favoriteLoading() = _FavoriteLoading;
  const factory FavoriteDrinkOfUserState.favoriteLoadError(String message) =
      _FavoriteLoadError;
  const factory FavoriteDrinkOfUserState.favoriteLoadSuccess(List<Drink> data) =
      _FavoriteLoadSuccess;
}
