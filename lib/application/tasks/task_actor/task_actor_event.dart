part of 'task_actor_bloc.dart';

@freezed
class TaskActorEvent with _$TaskActorEvent {
  const factory TaskActorEvent.deleteTaskPressed(TaskItem taskItem) =
      _DeleteTaskPressed;

  const factory TaskActorEvent.moveToNewTaskStatePressed(
      TaskItem taskItem, TaskState taskState) = _RemoveFromFavoritePressed;

  const factory TaskActorEvent.changeTaskPriorityPressed(
          TaskItem taskItem, TaskPriority taskPriority) =
      _ChangeTaskPriorityPressed;

  const factory TaskActorEvent.timerHistoryChanged(
      TimerHistory? newTimerHistory, TaskItem taskItem) = _TimerHistoryChanged;

  const factory TaskActorEvent.deleteTimerHistoryPressed(TaskItem taskItem) =
      _DeleteTimerHistoryPressed;
}
