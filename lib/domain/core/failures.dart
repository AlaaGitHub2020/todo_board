import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_board/domain/auth/auth_value_failure.dart';
import 'package:todo_board/domain/task/task_value_failure.dart';
import 'package:todo_board/domain/user_profile/user_value_failure.dart';

part 'failures.freezed.dart';

@freezed
class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.auth(AuthValueFailure<T> failure) = _Auth<T>;

  const factory ValueFailure.user(UserValueFailure<T> failure) = _User<T>;

  const factory ValueFailure.task(TaskValueFailure<T> failure) = _Task<T>;
}
