import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_board/domain/core/utilities/logger/simple_log_printer.dart';
import 'package:todo_board/domain/core/utilities/strings.dart';
import 'package:todo_board/domain/core/value_objects.dart';
import 'package:todo_board/domain/task/i_task_item_repository.dart';
import 'package:todo_board/domain/task/task_failure.dart';
import 'package:todo_board/domain/task/task_item.dart';
import 'package:todo_board/domain/task/timer_history/timer_history.dart';
import 'package:todo_board/domain/task_timer/i_task_timer_repository.dart';
import 'package:todo_board/domain/task_timer/task_timer_failure.dart';

part 'task_actor_bloc.freezed.dart';

part 'task_actor_event.dart';

part 'task_actor_state.dart';

@injectable
class TaskActorBloc extends Bloc<TaskActorEvent, TaskActorState> {
  final ITaskItemRepository _taskItemRepository;
  final ITaskTimerRepository _taskTimerRepository;
  final log = getLogger();

  TaskActorBloc(this._taskItemRepository, this._taskTimerRepository)
      : super(const TaskActorState.initial()) {
    on<TaskActorEvent>(
      (event, emit) async {
        await event.map(
          deleteTaskPressed: (e) async {
            log.i("deleteTaskPressed started");
            emit(const TaskActorState.actionInProgress());
            TaskActorState taskActorState = await _taskItemRepository
                .deleteUserTask(e.taskItem)
                .then((possibleFailure) {
              return possibleFailure.fold(
                (failure) => TaskActorState.deleteTaskFailure(failure),
                (_) => const TaskActorState.deleteTaskSuccess(),
              );
            });

            emit(taskActorState);
          },
          moveToNewTaskStatePressed: (e) async {
            log.i("moveToNewTaskStatePressed started");
            emit(const TaskActorState.actionInProgress());
            Either<TaskFailure, Unit> possibleFailure;
            if (e.taskState == TaskState.done) {
              possibleFailure =
                  await _taskItemRepository.updateUserTask(e.taskItem.copyWith(
                taskState: FirebaseStringValue(e.taskState.name),
                taskDateCompleted:
                    FirebaseStringValue(DateTime.now().toString()),
              ));
            } else {
              possibleFailure = await _taskItemRepository.updateUserTask(e
                  .taskItem
                  .copyWith(taskState: FirebaseStringValue(e.taskState.name)));
            }

            emit(
              possibleFailure.fold(
                (failure) => TaskActorState.moveToNewTaskStateFailure(failure),
                (_) => const TaskActorState.moveToNewTaskStateSuccess(),
              ),
            );
          },
          changeTaskPriorityPressed: (e) async {
            log.i("changeTaskPriorityPressed started");
            emit(const TaskActorState.actionInProgress());
            final possibleFailure = await _taskItemRepository.updateUserTask(
                e.taskItem.copyWith(
                    taskPriority: FirebaseStringValue(e.taskPriority.name)));
            emit(
              possibleFailure.fold(
                (failure) => TaskActorState.changeTaskPriorityFailure(failure),
                (_) => const TaskActorState.changeTaskPrioritySuccess(),
              ),
            );
          },
          timerHistoryChanged: (e) async {
            log.i("timerHistoryChanged started");
            emit(const TaskActorState.actionInProgress());
            final possibleFailure =
                await _taskTimerRepository.createNewUserTaskTimerHistory(
                    e.taskItem.id.getOrCrash()!, e.newTimerHistory!);
            emit(
              possibleFailure.fold(
                (failure) => TaskActorState.changedTimerHistoryFailure(failure),
                (_) => const TaskActorState.changedTimerHistorySuccess(),
              ),
            );
          },
          deleteTimerHistoryPressed: (e) async {
            log.i("deleteTimerHistoryPressed started");
            emit(const TaskActorState.actionInProgress());
            final possibleFailure = await _taskTimerRepository
                .deleteTaskTimerHistory(e.taskItem.id.getOrCrash()!);
            emit(
              possibleFailure.fold(
                (failure) => TaskActorState.changedTimerHistoryFailure(failure),
                (_) => const TaskActorState.changedTimerHistorySuccess(),
              ),
            );
          },
        );
      },
    );
  }
}
