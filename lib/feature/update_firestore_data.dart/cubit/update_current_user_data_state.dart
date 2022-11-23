part of 'update_current_user_data_cubit.dart';

@freezed
class UpdateCurrentUserDataState with _$UpdateCurrentUserDataState {
  const factory UpdateCurrentUserDataState.currentUserDataLoading() =
      _CurrentUserDataLoading;
  const factory UpdateCurrentUserDataState.currentUserDataError(
      String message) = _CurrentUserDataLoadFailure;
  const factory UpdateCurrentUserDataState.currentUserDataLoadSuccess(
      List<String> data) = _CurrentUserDataLoadSuccess;
}
