import 'package:dartz/dartz.dart';
import 'package:kt_dart/collection.dart';
import 'package:todo_board/domain/task/task_failure.dart';
import 'package:todo_board/domain/task/task_item.dart';
import 'package:todo_board/domain/task/timer_history/timer_history.dart';

abstract class ITaskItemRepository {
  Stream<Either<TaskFailure, KtList<TaskItem>>> watchAllUserTasks();

  Future<Either<TaskFailure, Unit>> createNewUserTask(TaskItem taskItem);

  Future<Either<TaskFailure, Unit>> updateUserTask(TaskItem taskItem);

  Future<Either<TaskFailure, Unit>> deleteUserTask(TaskItem taskItem);

  Stream<Either<TaskFailure, KtList<TimerHistory>>> watchUserTasksTimerHistory(
      TaskItem taskItem);
}
