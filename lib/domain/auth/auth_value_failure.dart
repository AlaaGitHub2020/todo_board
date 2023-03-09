import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_value_failure.freezed.dart';

@freezed
class AuthValueFailure<T> with _$AuthValueFailure<T> {
  const factory AuthValueFailure.invalidEmail({
    required T failedValue,
  }) = InvalidEmail<T>;

  const factory AuthValueFailure.shortPassword({
    required T failedValue,
  }) = ShortPassword<T>;

  const factory AuthValueFailure.passwordCanNotBeEmpty({
    required T failedValue,
  }) = PasswordCanNotBeEmpty<T>;
}
