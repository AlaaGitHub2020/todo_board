part of 'task_actor_bloc.dart';

@freezed
class TaskActorState with _$TaskActorState {
  const factory TaskActorState.initial() = _Initial;

  const factory TaskActorState.actionInProgress() = _ActionInProgress;

  const factory TaskActorState.deleteTaskFailure(TaskFailure taskFailure) =
      _DeleteTaskFailure;

  const factory TaskActorState.deleteTaskSuccess() = _DeleteTaskSuccess;

  const factory TaskActorState.moveToNewTaskStateFailure(
      TaskFailure taskFailure) = _MoveToNewTaskStateFailure;

  const factory TaskActorState.moveToNewTaskStateSuccess() =
      _MoveToNewTaskStateSuccess;

  const factory TaskActorState.changeTaskPriorityFailure(
      TaskFailure taskFailure) = _ChangeTaskPriorityFailure;

  const factory TaskActorState.changeTaskPrioritySuccess() =
      _ChangeTaskPrioritySuccess;

  const factory TaskActorState.changedTimerHistoryFailure(
      TaskTimerFailure taskFailure) = _ChangedTimerHistoryFailure;

  const factory TaskActorState.changedTimerHistorySuccess() =
      _ChangedTimerHistorySuccess;
}
