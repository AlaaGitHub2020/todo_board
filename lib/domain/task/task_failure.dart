import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_failure.freezed.dart';

@freezed
class TaskFailure with _$TaskFailure {
  const factory TaskFailure.unexpected() = _Unexpected;

  const factory TaskFailure.platFormServerFailure() = _PlatFormServerFailure;

  const factory TaskFailure.insufficientPermission() = _InsufficientPermission;

  const factory TaskFailure.unableToUpdate() = _UnableToUpdate;

  const factory TaskFailure.taskIsEmptyPleaseFillItFirst() =
      _TaskIsEmptyPleaseFillItFirst;
}
