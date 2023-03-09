import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_board/domain/core/entity.dart';
import 'package:todo_board/domain/core/failures.dart';
import 'package:todo_board/domain/core/value_objects.dart';

part 'timer_history.freezed.dart';

@freezed
class TimerHistory with _$TimerHistory implements IEntity {
  const factory TimerHistory({
    required UniqueId id,
    FirebaseStringValue? taskTimeSpent,
    FirebaseStringValue? timerStopDate,
  }) = _TimerHistory;

  factory TimerHistory.empty() => TimerHistory(
        id: UniqueId(),
        taskTimeSpent: FirebaseStringValue(''),
        timerStopDate: FirebaseStringValue(''),
      );
}

extension TimerHistoryX on TimerHistory {
  Option<ValueFailure<dynamic>> get failureOption {
    return taskTimeSpent!.failureOrUnit
        .andThen(timerStopDate!.failureOrUnit)
        .fold((f) => some(f), (_) => none());
  }
}
