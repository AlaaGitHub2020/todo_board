import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_value_failure.freezed.dart';

@freezed
class UserValueFailure<T> with _$UserValueFailure<T> {
  const factory UserValueFailure.invalidUserName({
    required T failedValue,
  }) = InvalidUserName<T>;
}
