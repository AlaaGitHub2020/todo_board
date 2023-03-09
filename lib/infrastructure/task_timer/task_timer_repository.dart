import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:todo_board/domain/analytics/i_analytics_repository.dart';
import 'package:todo_board/domain/core/utilities/helper.dart';
import 'package:todo_board/domain/core/utilities/logger/simple_log_printer.dart';
import 'package:todo_board/domain/core/value_objects.dart';
import 'package:todo_board/domain/task/task_item.dart';
import 'package:todo_board/domain/task/timer_history/timer_history.dart';
import 'package:todo_board/domain/task_timer/i_task_timer_repository.dart';
import 'package:todo_board/domain/task_timer/task_timer_failure.dart';
import 'package:todo_board/infrastructure/core/firestore_helpers.dart';
import 'package:todo_board/infrastructure/task/timer_history/timer_history_data_transfer_object.dart';

@LazySingleton(as: ITaskTimerRepository)
class TaskTimerRepository implements ITaskTimerRepository {
  final IAnalyticsRepository _analytics;
  final FirebaseFirestore _firebaseFireStore;

  final log = getLogger();

  TaskTimerRepository(
    this._analytics,
    this._firebaseFireStore,
  );

  @override
  StopWatchTimer stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
    onChange: (value) {
      if (kDebugMode) {
        print('onChange $value');
      }
    },
    onChangeRawSecond: (value) {
      if (kDebugMode) {
        print('onChangeRawSecond $value');
      }
    },
    onChangeRawMinute: (value) {
      if (kDebugMode) {
        print('onChangeRawMinute $value');
      }
    },
    onStopped: () {
      if (kDebugMode) {
        print('onStop');
      }
    },
    onEnded: () {
      if (kDebugMode) {
        print('onEnded');
      }
    },
  );

  @override
  Future<Either<TaskTimerFailure, Unit>> startTaskTimer(
      TaskItem taskItem) async {
    try {
      log.i("startTaskTimer Started");

      stopWatchTimer.onStartTimer();
      await _analytics.logStartTaskTimer(taskId: taskItem.id.getOrCrash());
      return right(unit);
    } catch (error) {
      log.e("ERROR :$error");
      await _analytics.logErrorHappened(errorDescription: error.toString());
      return left(const TaskTimerFailure.unableToStartTimer());
    }
  }

  @override
  Future<Either<TaskTimerFailure, TimerHistory>> stopTaskTimer(
      TaskItem taskItem) async {
    try {
      log.i("stopTaskTimer Started");
      int timeSpendInSeconds = (stopWatchTimer.rawTime.value) ~/ 1000;
      var spentTimeOnTask =
          Helper().getTaskTimeSpentFormattedToSaveInDB(timeSpendInSeconds);
      TimerHistory newTimerHistory = TimerHistory(
        id: UniqueId(),
        taskTimeSpent: FirebaseStringValue(spentTimeOnTask.toString()),
      );

      stopWatchTimer.onResetTimer();

      await _analytics.logStopTaskTimer(taskId: taskItem.id.getOrCrash());
      return right(newTimerHistory);
    } catch (error) {
      log.e("ERROR :$error");
      await _analytics.logErrorHappened(errorDescription: error.toString());
      return left(const TaskTimerFailure.unableToStopTimer());
    }
  }

  @override
  Future<Either<TaskTimerFailure, Unit>> createNewUserTaskTimerHistory(
      String taskId, TimerHistory timerHistory) async {
    try {
      log.i("createNewUserTaskTimerHistory Started");
      final userDoc = await _firebaseFireStore.userDocument();
      final timerHistoryDto = TimerHistoryDto.fromDomain(timerHistory);
      await userDoc
          .taskTimerHistoryCollection(taskId)
          .doc(timerHistoryDto.id)
          .set(timerHistoryDto.toJson());
      await _analytics.logCreateUserTaskTimerHistory(
          taskId: timerHistoryDto.id,
          userId: userDoc.toString(),
          timerHistoryId: timerHistoryDto.id);
      return right(unit);
    } on PlatformException catch (error) {
      log.e("ERROR :$error");
      await _analytics.logErrorHappened(errorDescription: error.toString());
      if (error.message!.contains("permission-denied")) {
        return left(const TaskTimerFailure.insufficientPermission());
      } else {
        return left(const TaskTimerFailure.unexpected());
      }
    }
  }
}
