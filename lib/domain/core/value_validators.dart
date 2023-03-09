import 'package:dartz/dartz.dart';
import 'package:todo_board/domain/auth/auth_value_failure.dart';
import 'package:todo_board/domain/core/failures.dart';
import 'package:todo_board/domain/core/utilities/strings.dart';
import 'package:todo_board/generated/l10n.dart';

Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  if (RegExp(Strings.pEmailPattern).hasMatch(input.trim())) {
    return right(input);
  } else {
    return left(
      ValueFailure.auth(AuthValueFailure.invalidEmail(failedValue: input)),
    );
  }
}

Either<ValueFailure<String>, String> validatePassword(String input) {
  S appLocalizations = S.current;

  if (input.isNotEmpty && input.length > 7) {
    return right(input);
  } else {
    if (input.isEmpty) {
      return left(
        ValueFailure.auth(
          AuthValueFailure.passwordCanNotBeEmpty(
            failedValue: appLocalizations.required,
          ),
        ),
      );
    } else if (input.length < 8) {
      return left(
        ValueFailure.auth(
          AuthValueFailure.shortPassword(
            failedValue: appLocalizations.passwordMinimumLength,
          ),
        ),
      );
    }
    return left(
      ValueFailure.auth(
        AuthValueFailure.shortPassword(
          failedValue: input,
        ),
      ),
    );
  }
}

Either<ValueFailure<String?>, String?> validateFirebaseStringValue(
    String? input) {
  //todo: add the validators here
  if (input != null) {
    return right(input);
  } else {
    return right('');
  }
}

