import 'package:dartz/dartz.dart';
import 'package:todo_board/domain/core/failures.dart';

Either<ValueFailure<String?>, String?> validateUserName(String? input) {
  if (input != null) {
    return right(input);
  } else {
    return right("");
  }
}

Either<ValueFailure<String?>, String?> validateAppBuildNumber(String? input) {
  if (input != null) {
    return right(input);
  } else {
    return right("");
  }
}

Either<ValueFailure<String?>, String?> validateAppVersion(String? input) {
  if (input != null) {
    return right(input);
  } else {
    return right("");
  }
}

Either<ValueFailure<String?>, String?> validateLastAppOpen(String? input) {
  if (input != null) {
    return right(input);
  } else {
    return right("");
  }
}
