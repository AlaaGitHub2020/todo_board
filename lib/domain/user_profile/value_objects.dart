import 'package:dartz/dartz.dart';
import 'package:todo_board/domain/core/failures.dart';
import 'package:todo_board/domain/core/value_objects.dart';
import 'package:todo_board/domain/user_profile/value_validators.dart';

class UserName extends ValueObject<String?> {
  @override
  final Either<ValueFailure<String?>, String?> value;

  factory UserName(String? input) {
    return UserName._(
      validateUserName(input),
    );
  }

  const UserName._(this.value);
}

class AppBuildNumber extends ValueObject<String?> {
  @override
  final Either<ValueFailure<String?>, String?> value;

  factory AppBuildNumber(String? input) {
    return AppBuildNumber._(
      validateAppBuildNumber(input),
    );
  }

  const AppBuildNumber._(this.value);
}

class AppVersion extends ValueObject<String?> {
  @override
  final Either<ValueFailure<String?>, String?> value;

  factory AppVersion(String? input) {
    return AppVersion._(
      validateAppVersion(input),
    );
  }

  const AppVersion._(this.value);
}

class LastAppOpen extends ValueObject<String?> {
  @override
  final Either<ValueFailure<String?>, String?> value;

  factory LastAppOpen(String? input) {
    return LastAppOpen._(
      validateLastAppOpen(input),
    );
  }

  const LastAppOpen._(this.value);
}
