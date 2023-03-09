part of 'task_timer_history_watcher_bloc.dart';

@freezed
class TaskTimerHistoryWatcherEvent with _$TaskTimerHistoryWatcherEvent {
  const factory TaskTimerHistoryWatcherEvent.watchUserTasksTimerHistoryStarted(TaskItem taskItem) =
      _WatchUserTasksTimerHistoryStarted;

  const factory TaskTimerHistoryWatcherEvent.userTasksTimerHistoryReceived(
          Either<TaskFailure, KtList<TimerHistory>> failureOrTimerHistoryList) =
      _UserTasksTimerHistoryReceived;
}
