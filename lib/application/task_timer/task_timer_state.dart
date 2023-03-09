part of 'task_timer_bloc.dart';

@freezed
class TaskTimerState with _$TaskTimerState {
  const factory TaskTimerState.initial() = _Initial;

  const factory TaskTimerState.timerWorking(TaskItem taskItem) = _TimerWorking;

  const factory TaskTimerState.timerStopped(TaskItem taskItem) = _TimerStopped;

  const factory TaskTimerState.timerFailure(TaskTimerFailure taskTimerFailure) =
      _TimerFailure;
}
