part of 'user_profile_watcher_bloc.dart';

@freezed
class UserProfileWatcherEvent with _$UserProfileWatcherEvent {
  const factory UserProfileWatcherEvent.watchUserProfileStarted() =
      _WatchUserProfileStarted;

  const factory UserProfileWatcherEvent.userProfileReceived(
          Either<AuthFailure, UserProfile> failureOrUserProfile) =
      _UserProfileReceived;
}
