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

part 'tasks_watcher_bloc.freezed.dart';

part 'tasks_watcher_event.dart';

part 'tasks_watcher_state.dart';

@injectable
class TasksWatcherBloc extends Bloc<TasksWatcherEvent, TasksWatcherState> {
  final ITaskItemRepository _taskItemRepository;
  final log = getLogger();

  late StreamSubscription<Either<TaskFailure, KtList<TaskItem>>>
      _taskStreamSubscription;

  TasksWatcherBloc(this._taskItemRepository)
      : super(const TasksWatcherState.initial()) {
    _taskStreamSubscription = _taskItemRepository.watchAllUserTasks().listen(
          (failureOrTasks) => add(
            TasksWatcherEvent.tasksReceived(failureOrTasks),
          ),
        );
    on<TasksWatcherEvent>((event, emit) async {
      await event.map(
        watchAllTasksStarted: (e) async {
          log.i("watchAllTasksStarted started");
          emit(const TasksWatcherState.loadInProgress());
          await _taskStreamSubscription.cancel();
          _taskStreamSubscription =
              _taskItemRepository.watchAllUserTasks().listen(
                    (failureOrTasks) => add(
                      TasksWatcherEvent.tasksReceived(failureOrTasks),
                    ),
                  );
        },
        tasksReceived: (e) async {
          log.i("tasksReceived started");
          emit(e.failureOrTasks.fold(
            (failure) => TasksWatcherState.loadFailure(failure),
            (tasks) => TasksWatcherState.loadSuccess(tasks),
          ));
        },
      );
    });
  }

  @override
  Future<void> close() async {
    log.i("close started");
    await _taskStreamSubscription.cancel();
    return super.close();
  }
}
