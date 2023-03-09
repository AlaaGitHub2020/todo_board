part of 'task_timer_bloc.dart';

@freezed
class TaskTimerEvent with _$TaskTimerEvent {
  const factory TaskTimerEvent.startTimerPressed({required TaskItem taskItem}) =
      StartTimerPressed;

  const factory TaskTimerEvent.stopTimerPressed(
      {required TaskItem taskItem,
      required BuildContext context}) = StopTimerPressed;
}
