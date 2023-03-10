import 'package:dartz/dartz.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:todo_board/domain/task/task_item.dart';
import 'package:todo_board/domain/task/timer_history/timer_history.dart';
import 'package:todo_board/domain/task_timer/task_timer_failure.dart';

abstract class ITaskTimerRepository {
  late StopWatchTimer stopWatchTimer;

  Future<Either<TaskTimerFailure, Unit>> startTaskTimer(TaskItem taskItem);

  Future<Either<TaskTimerFailure, TimerHistory>> stopTaskTimer(
      TaskItem taskItem);

  Future<Either<TaskTimerFailure, Unit>> createNewUserTaskTimerHistory(
      String taskId, TimerHistory timerHistory);

  Future<Either<TaskTimerFailure, Unit>> deleteTaskTimerHistory(String taskId);
}
