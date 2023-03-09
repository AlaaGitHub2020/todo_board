part of 'user_profile_watcher_bloc.dart';

@freezed
class UserProfileWatcherState with _$UserProfileWatcherState {
  const factory UserProfileWatcherState.initial() = _Initial;

  const factory UserProfileWatcherState.loadInProgress() = _LoadInProgress;

  const factory UserProfileWatcherState.loadSuccess(UserProfile userProfile) =
      _LoadSuccess;

  const factory UserProfileWatcherState.loadFailure(AuthFailure userFailure) =
      _LoadFailure;
}
