import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_board/domain/core/entity.dart';
import 'package:todo_board/domain/core/failures.dart';
import 'package:todo_board/domain/core/utilities/strings.dart';
import 'package:todo_board/domain/core/value_objects.dart';

part 'user_fcm_token.freezed.dart';

@freezed
class UserFCMToken with _$UserFCMToken implements IEntity {
  const factory UserFCMToken({
    required UniqueId id,
    FirebaseStringValue? createdAt,
    FirebaseStringValue? updatedAt,
    FirebaseStringValue? platform,
    FirebaseStringValue? fcmToken,
  }) = _UserFCMToken;

  factory UserFCMToken.empty() => UserFCMToken(
        id: UniqueId.fromUniqueString(
            "${Strings.cUserFCMTokensID}${kIsWeb ? Strings.cWebBrowser : Platform.operatingSystem}"),
        createdAt: FirebaseStringValue(DateTime.now().toString()),
        updatedAt: FirebaseStringValue(DateTime.now().toString()),
        platform: FirebaseStringValue(
            kIsWeb ? Strings.cWebBrowser : Platform.operatingSystem),
        fcmToken: FirebaseStringValue(''),
      );
}

extension UserFCMTokenX on UserFCMToken {
  Option<ValueFailure<dynamic>>? get failureOption {
    return createdAt?.failureOrUnit
        .andThen(updatedAt!.failureOrUnit)
        .andThen(platform!.failureOrUnit)
        .andThen(fcmToken!.failureOrUnit)
        .fold((failure) => some(failure), (_) => none());
  }
}
