part of 'tasks_watcher_bloc.dart';

@freezed
class TasksWatcherEvent with _$TasksWatcherEvent {
  const factory TasksWatcherEvent.watchAllTasksStarted() =
      _WatchAllTasksStarted;

  const factory TasksWatcherEvent.tasksReceived(
      Either<TaskFailure, KtList<TaskItem>> failureOrTasks) = _TasksReceived;
}
