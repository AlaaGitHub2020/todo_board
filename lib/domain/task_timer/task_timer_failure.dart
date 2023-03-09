import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_timer_failure.freezed.dart';

@freezed
class TaskTimerFailure with _$TaskTimerFailure {
  const factory TaskTimerFailure.unexpected() = _Unexpected;

  const factory TaskTimerFailure.insufficientPermission() =
      _InsufficientPermission;

  const factory TaskTimerFailure.unableToStartTimer() = _UnableToStartTimer;

  const factory TaskTimerFailure.unableToStopTimer() = _UnableToStopTimer;
}
