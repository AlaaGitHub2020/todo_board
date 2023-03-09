import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';
import 'package:todo_board/domain/core/utilities/logger/simple_log_printer.dart';
import 'package:todo_board/domain/task/i_task_item_repository.dart';
import 'package:todo_board/domain/task/task_failure.dart';
import 'package:todo_board/domain/task/task_item.dart';
import 'package:todo_board/domain/task/timer_history/timer_history.dart';

part 'task_timer_history_watcher_bloc.freezed.dart';

part 'task_timer_history_watcher_event.dart';

part 'task_timer_history_watcher_state.dart';

@injectable
class TaskTimerHistoryWatcherBloc
    extends Bloc<TaskTimerHistoryWatcherEvent, TaskTimerHistoryWatcherState> {
  final ITaskItemRepository _taskItemRepository;
  final log = getLogger();

  late StreamSubscription<Either<TaskFailure, KtList<TimerHistory>>>
      _taskTimerHistoryStreamSubscription;

  TaskTimerHistoryWatcherBloc(this._taskItemRepository)
      : super(const TaskTimerHistoryWatcherState.initial()) {
    on<TaskTimerHistoryWatcherEvent>((event, emit) async {
      await event.map(
        watchUserTasksTimerHistoryStarted: (e) async {
          log.i("watchUserTasksTimerHistoryStarted started");
          emit(const TaskTimerHistoryWatcherState.loadInProgress());

          _taskTimerHistoryStreamSubscription = _taskItemRepository
              .watchUserTasksTimerHistory(e.taskItem)
              .listen(
                (failureOrTasksTimerHistoryList) => add(
                  TaskTimerHistoryWatcherEvent.userTasksTimerHistoryReceived(
                      failureOrTasksTimerHistoryList),
                ),
              );
        },
        userTasksTimerHistoryReceived: (e) async {
          log.i("userTasksTimerHistoryReceived started");
          emit(e.failureOrTimerHistoryList.fold(
            (failure) => TaskTimerHistoryWatcherState.loadFailure(failure),
            (userTasksTimerHistoryList) =>
                TaskTimerHistoryWatcherState.loadSuccess(
                    userTasksTimerHistoryList),
          ));
        },
      );
    });
  }

  @override
  Future<void> close() async {
    log.i("close started");
    await _taskTimerHistoryStreamSubscription.cancel();
    return super.close();
  }
}
