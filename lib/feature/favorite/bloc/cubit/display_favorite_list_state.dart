part of 'display_favorite_list_cubit.dart';

@freezed
class DisplayFavoriteListState with _$DisplayFavoriteListState {
  const factory DisplayFavoriteListState.favoriteToDisplayLoading() =
      _FavoriteToDisplayLoading;
  const factory DisplayFavoriteListState.favoriteToDisplayFailure(
      String message) = _FavoriteToDisplayFailure;
  const factory DisplayFavoriteListState.favoriteToDisplaySuccess(
      DrinksData data) = _FavoriteToDisplaySuccess;
}
