import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_board/domain/auth/value_objects.dart';
import 'package:todo_board/domain/core/entity.dart';
import 'package:todo_board/domain/core/failures.dart';
import 'package:todo_board/domain/core/value_objects.dart';
import 'package:todo_board/domain/user_profile/value_objects.dart';

part 'user.freezed.dart';

@freezed
class User with _$User implements IEntity {
  const factory User({
    required UniqueId id,
    required UserName userName,
    required EmailAddress emailAddress,
  }) = _User;
}

extension UserX on User {
  Option<ValueFailure<dynamic>> get failureOption {
    return userName.failureOrUnit
        .andThen(emailAddress.failureOrUnit)
        .fold((l) => some(l), (r) => none());
  }
}
