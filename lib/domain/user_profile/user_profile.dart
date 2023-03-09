import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_board/domain/auth/value_objects.dart';
import 'package:todo_board/domain/user_profile/value_objects.dart';

part 'user_profile.freezed.dart';

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    UserName? userName,
    required EmailAddress emailAddress,
    AppBuildNumber? appBuildNumber,
    AppVersion? appVersion,
    LastAppOpen? lastAppOpen,
  }) = _UserProfile;

  factory UserProfile.empty() => UserProfile(
      userName: UserName(''),
      emailAddress: EmailAddress(''),
      appBuildNumber: AppBuildNumber(''),
      appVersion: AppVersion(''),
      lastAppOpen: LastAppOpen(''));
}
