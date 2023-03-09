import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:todo_board/domain/analytics/i_analytics_repository.dart';
import 'package:todo_board/domain/auth/auth_failure.dart';
import 'package:todo_board/domain/core/utilities/logger/simple_log_printer.dart';
import 'package:todo_board/domain/user_profile/i_user_profile_repository.dart';
import 'package:todo_board/domain/user_profile/user_profile.dart';
import 'package:todo_board/domain/user_profile/value_objects.dart';
import 'package:todo_board/infrastructure/core/firestore_helpers.dart';
import 'package:todo_board/infrastructure/user_profile/user_profile_data_transfer_object.dart';
import 'package:todo_board/injection.dart';

@LazySingleton(as: IUserProfileRepository)
class UserProfileRepository implements IUserProfileRepository {
  final FirebaseFirestore _firebaseFireStore;
  final IAnalyticsRepository _analytics;

  final log = getLogger();

  UserProfileRepository(
    this._firebaseFireStore,
    this._analytics,
  );

  @override
  Future<Either<AuthFailure, UserProfile>> getUpdatedUser() async {
    try {
      log.i("getUpdatedUser Started");
      final userDoc = await _firebaseFireStore.userDocument();
      final userProfileDto =
          UserProfileDto.fromFireStore(await userDoc.get()).toDomain();
      if (userProfileDto != null) {
        await _analytics.logGetUpdatedUser(userId: userDoc.toString());
        return right(userProfileDto);
      } else {
        log.e("userProfileDto IS NULL");
        await _analytics.logErrorHappened(
            errorDescription: "userProfileDataError");
        return left(const AuthFailure.userProfileDataError());
      }
    } on PlatformException catch (error) {
      log.e("ERROR :$error");
      await _analytics.logErrorHappened(errorDescription: error.toString());
      return left(const AuthFailure.userProfileDataError());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> createUserProfile(
      UserProfile userProfile, String userEmail) async {
    try {
      log.i("createUserProfile Started");
      final userDoc = await _firebaseFireStore.userDocument();
      String? appVersion = getIt<PackageInfo>().version;
      String? appBuildNumber = getIt<PackageInfo>().buildNumber;
      String? lastAppOpen = DateTime.now().toString();
      UserProfile theUNewUerProfile = userProfile.copyWith(
        appBuildNumber: AppBuildNumber(appBuildNumber),
        appVersion: AppVersion(appVersion),
        lastAppOpen: LastAppOpen(lastAppOpen),
      );
      final userProfileDto =
          UserProfileDto.fromDomain(theUNewUerProfile, userEmail);
      await userDoc.set(userProfileDto.toJson()).catchError((value) {
        if (value.toString().contains("not-found")) {
          log.e("******userProfile not-found*******");
        }
      });
      await _analytics.logCreateUser(userId: userEmail);
      return right(unit);
    } on PlatformException catch (error) {
      log.e("ERROR :$error");
      await _analytics.logErrorHappened(errorDescription: error.toString());
      return left(const AuthFailure.userProfileDataError());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> deleteUserProfile() async {
    try {
      log.i("deleteUserProfile Started");
      final userDoc = await _firebaseFireStore.userDocument();
      await userDoc.delete();
      await _analytics.logDeleteUser(userId: userDoc.toString());
      return right(unit);
    } on PlatformException catch (error) {
      log.e("ERROR :$error");
      await _analytics.logErrorHappened(errorDescription: error.toString());
      return left(const AuthFailure.userProfileDataError());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> updateUserProfile(
      UserProfile? userProfile, String userEmail) async {
    try {
      log.i("updateUserProfile Started");
      if (userProfile != null) {
        final userDoc = await _firebaseFireStore.userDocument();
        String? appVersion = getIt<PackageInfo>().version;
        String? appBuildNumber = getIt<PackageInfo>().buildNumber;
        String? lastAppOpen = DateTime.now().toString();
        UserProfile theUNewUerProfile = userProfile.copyWith(
          appVersion: AppVersion(appVersion),
          appBuildNumber: AppBuildNumber(appBuildNumber),
          lastAppOpen: LastAppOpen(lastAppOpen),
        );
        final userProfileDto =
            UserProfileDto.fromDomain(theUNewUerProfile, userEmail);
        await userDoc.update(userProfileDto.toJson()).catchError((value) {
          if (value.toString().contains("not-found")) {
            log.e("****UerProfile not-found****");
            createUserProfile(theUNewUerProfile, userEmail);
          }
        });
        await _analytics.logUpdateUser(userId: "$userEmail||||||||$userDoc");
        return right(unit);
      } else {
        await _analytics.logErrorHappened(
            errorDescription: 'userProfileDataError');
        return left(const AuthFailure.userProfileDataError());
      }
    } on PlatformException catch (error) {
      log.e("ERROR :$error");
      await _analytics.logErrorHappened(errorDescription: error.toString());
      return left(const AuthFailure.userProfileDataError());
    }
  }
}
