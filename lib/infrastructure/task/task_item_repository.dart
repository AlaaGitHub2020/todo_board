import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo_board/domain/analytics/i_analytics_repository.dart';
import 'package:todo_board/domain/core/utilities/logger/simple_log_printer.dart';
import 'package:todo_board/domain/core/utilities/strings.dart';
import 'package:todo_board/domain/task/i_task_item_repository.dart';
import 'package:todo_board/domain/task/task_failure.dart';
import 'package:todo_board/domain/task/task_item.dart';
import 'package:todo_board/domain/task/timer_history/timer_history.dart';
import 'package:todo_board/infrastructure/core/firestore_helpers.dart';
import 'package:todo_board/infrastructure/task/task_item_data_transfer_object.dart';
import 'package:todo_board/infrastructure/task/timer_history/timer_history_data_transfer_object.dart';

@LazySingleton(as: ITaskItemRepository)
class TaskItemRepository implements ITaskItemRepository {
  final FirebaseFirestore _firebaseFireStore;
  final IAnalyticsRepository _analytics;

  final log = getLogger();

  TaskItemRepository(
    this._firebaseFireStore,
    this._analytics,
  );

  @override
  Future<Either<TaskFailure, Unit>> createNewUserTask(TaskItem taskItem) async {
    try {
      log.i("createNewUserTask Started");
      final userDoc = await _firebaseFireStore.userDocument();
      final taskDto = TaskItemDto.fromDomain(taskItem);
      await userDoc.taskCollection.doc(taskDto.id).set(taskDto.toJson());
      await _analytics.logCreateNewUserTask(
          taskId: taskDto.id, userId: userDoc.toString());
      return right(unit);
    } on PlatformException catch (error) {
      log.e("ERROR :$error");
      await _analytics.logErrorHappened(errorDescription: error.toString());
      if (error.message!.contains("permission-denied")) {
        return left(const TaskFailure.insufficientPermission());
      } else {
        return left(const TaskFailure.unexpected());
      }
    }
  }

  @override
  Future<Either<TaskFailure, Unit>> deleteUserTask(TaskItem taskItem) async {
    try {
      log.i("deleteUserTask Started");
      final userDoc = await _firebaseFireStore.userDocument();
      final taskId = taskItem.id.getOrCrash();
      await userDoc.deleteTaskTimerHistoryCollection(taskId!);
      await userDoc.taskCollection.doc(taskId).delete();
      await _analytics.logDeleteUserTask(taskId: taskId);
      return right(unit);
    } on PlatformException catch (error) {
      log.e("ERROR :$error");
      await _analytics.logErrorHappened(errorDescription: error.toString());
      if (error.message!.contains("PERMISSION_DENIED")) {
        return left(const TaskFailure.insufficientPermission());
      }
      if (error.message!.contains("NOT_FOUND")) {
        return left(const TaskFailure.unableToUpdate());
      } else {
        return left(const TaskFailure.unexpected());
      }
    }
  }

  @override
  Future<Either<TaskFailure, Unit>> updateUserTask(TaskItem taskItem) async {
    try {
      log.i("updateUserTask Started");
      final userDoc = await _firebaseFireStore.userDocument();
      final taskDto = TaskItemDto.fromDomain(taskItem);
      await userDoc.taskCollection.doc(taskDto.id).update(taskDto.toJson());
      await _analytics.logUpdateUserTask(taskId: taskDto.id);
      return right(unit);
    } on PlatformException catch (error) {
      log.e("ERROR :$error");
      await _analytics.logErrorHappened(errorDescription: error.toString());
      if (error.message!.contains("PERMISSION_DENIED")) {
        return left(const TaskFailure.insufficientPermission());
      }
      if (error.message!.contains("NOT_FOUND")) {
        return left(const TaskFailure.unableToUpdate());
      } else {
        return left(const TaskFailure.unexpected());
      }
    }
  }

  @override
  Stream<Either<TaskFailure, KtList<TaskItem>>> watchAllUserTasks() async* {
    log.i("watchAllUserTasks Started");
    final userDoc = await _firebaseFireStore.userDocument();
    await _analytics.logWatchAllUserTasks();
    yield* userDoc.taskCollection
        .orderBy(Strings.cCreatedAt, descending: true)
        .snapshots()
        .map((snapshot) => right<TaskFailure, KtList<TaskItem>>(
              snapshot.docs
                  .map((doc) => TaskItemDto.fromFireStore(doc).toDomain())
                  .toImmutableList(),
            ))
        .onErrorReturnWith((error, stackTrace) {
      log.e("ERROR :$error");
      log.e("stackTrace :$stackTrace");
      if (error is FirebaseException &&
          error.code.contains("permission-denied")) {
        return left(const TaskFailure.insufficientPermission());
      } else if (error is FirebaseException) {
        return left(const TaskFailure.platFormServerFailure());
      } else {
        return left(const TaskFailure.unexpected());
      }
    });
  }

  @override
  Stream<Either<TaskFailure, KtList<TimerHistory>>> watchUserTasksTimerHistory(
      TaskItem taskItem) async* {
    log.i("watchUserTasksTimerHistory Started");
    final userDoc = await _firebaseFireStore.userDocument();
    await _analytics.logWatchUserTasksTimerHistory();
    yield* userDoc
        .taskTimerHistoryCollection(taskItem.id.getOrCrash()!)
        .orderBy(Strings.cTimerStopDate, descending: true)
        .snapshots()
        .map((snapshot) => right<TaskFailure, KtList<TimerHistory>>(
              snapshot.docs
                  .map((doc) => TimerHistoryDto.fromFireStore(doc).toDomain())
                  .toImmutableList(),
            ))
        .onErrorReturnWith((error, stackTrace) {
      log.e("ERROR :$error");
      log.e("stackTrace :$stackTrace");
      if (error is FirebaseException &&
          error.code.contains("permission-denied")) {
        return left(const TaskFailure.insufficientPermission());
      } else if (error is FirebaseException) {
        return left(const TaskFailure.platFormServerFailure());
      } else {
        return left(const TaskFailure.unexpected());
      }
    });
  }
}
