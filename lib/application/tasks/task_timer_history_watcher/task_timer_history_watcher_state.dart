part of 'task_timer_history_watcher_bloc.dart';

@freezed
class TaskTimerHistoryWatcherState with _$TaskTimerHistoryWatcherState {
  const factory TaskTimerHistoryWatcherState.initial() = _Initial;

  const factory TaskTimerHistoryWatcherState.loadInProgress() = _LoadInProgress;

  const factory TaskTimerHistoryWatcherState.loadSuccess(
      KtList<TimerHistory> timerHistoryList) = _LoadSuccess;

  const factory TaskTimerHistoryWatcherState.loadFailure(
      TaskFailure taskFailure) = _LoadFailure;
}
