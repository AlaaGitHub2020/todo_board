part of 'tasks_watcher_bloc.dart';

@freezed
class TasksWatcherState with _$TasksWatcherState {
  const factory TasksWatcherState.initial() = _Initial;

  const factory TasksWatcherState.loadInProgress() = _LoadInProgress;

  const factory TasksWatcherState.loadSuccess(KtList<TaskItem> tasksList) =
      _LoadSuccess;

  const factory TasksWatcherState.loadFailure(TaskFailure taskFailure) =
      _LoadFailure;
}
