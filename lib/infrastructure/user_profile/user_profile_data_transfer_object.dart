import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:todo_board/domain/auth/value_objects.dart';
import 'package:todo_board/domain/core/utilities/logger/simple_log_printer.dart';
import 'package:todo_board/domain/user_profile/user_profile.dart';
import 'package:todo_board/domain/user_profile/value_objects.dart';
import 'package:todo_board/infrastructure/core/server_timestamp_converter.dart';
import 'package:todo_board/injection.dart';

part 'user_profile_data_transfer_object.freezed.dart';

part 'user_profile_data_transfer_object.g.dart';

///Dto: data transfer object
@freezed
class UserProfileDto with _$UserProfileDto {
  factory UserProfileDto({
    String? userName,
    required String? emailAddress,
    @ServerTimestampConverter() FieldValue? serverTimeStamp,
    String? appBuildNumber,
    String? appVersion,
    String? lastAppOpen,
  }) = _UserProfileDto;

  factory UserProfileDto.fromDomain(UserProfile userProfile, String userEmail) {
    String? appVersion = getIt<PackageInfo>().version;
    String? appBuildNumber = getIt<PackageInfo>().buildNumber;
    String? lastAppOpen = DateTime.now().toString();
    return UserProfileDto(
      userName: userProfile.userName?.getOrCrash() ?? "",
      emailAddress: userEmail,
      serverTimeStamp: FieldValue.serverTimestamp(),
      appVersion:
          userProfile.appVersion?.value.fold((l) => appVersion, (r) => r) ??
              appVersion,
      appBuildNumber: userProfile.appBuildNumber?.value
              .fold((l) => appBuildNumber, (r) => r) ??
          appBuildNumber,
      lastAppOpen:
          userProfile.lastAppOpen?.value.fold((l) => lastAppOpen, (r) => r) ??
              lastAppOpen,
    );
  }

  factory UserProfileDto.fromJson(Map<String, dynamic> json) =>
      _$UserProfileDtoFromJson(json);

  factory UserProfileDto.fromFireStore(DocumentSnapshot doc) {
    final log = getLogger();
    log.i(doc.data());
    Map<String, dynamic> jsonFromFireStoreObject =
        doc.data() as Map<String, dynamic>;
    return UserProfileDto.fromJson(jsonFromFireStoreObject);
  }
}

extension UserProfileDtoX on UserProfileDto {
  UserProfile? toDomain() {
    return UserProfile(
      userName: UserName(userName),
      emailAddress: EmailAddress(emailAddress!),
      appBuildNumber: AppBuildNumber(appBuildNumber),
      appVersion: AppVersion(appVersion),
      lastAppOpen: LastAppOpen(lastAppOpen),
    );
  }
}
