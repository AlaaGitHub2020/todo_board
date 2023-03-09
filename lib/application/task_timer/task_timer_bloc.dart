import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_board/application/tasks/task_actor/task_actor_bloc.dart';
import 'package:todo_board/domain/core/utilities/logger/simple_log_printer.dart';
import 'package:todo_board/domain/core/value_objects.dart';
import 'package:todo_board/domain/task/task_item.dart';
import 'package:todo_board/domain/task/timer_history/timer_history.dart';
import 'package:todo_board/domain/task_timer/i_task_timer_repository.dart';
import 'package:todo_board/domain/task_timer/task_timer_failure.dart';

part 'task_timer_bloc.freezed.dart';

part 'task_timer_event.dart';

part 'task_timer_state.dart';

@injectable
class TaskTimerBloc extends Bloc<TaskTimerEvent, TaskTimerState> {
  final ITaskTimerRepository _taskTimerRepository;
  final log = getLogger();

  TaskTimerBloc(this._taskTimerRepository)
      : super(const TaskTimerState.initial()) {
    on<TaskTimerEvent>(
      (event, emit) async {
        await event.map(
          startTimerPressed: (e) async {
            log.i("startTimerPressed Started ");
            Either<TaskTimerFailure, Unit> possibleFailure =
                await _taskTimerRepository.startTaskTimer(e.taskItem);

            possibleFailure.fold((failure) {
              emit(TaskTimerState.timerFailure(failure));
            }, (success) {
              emit(TaskTimerState.timerWorking(e.taskItem));
            });
          },
          stopTimerPressed: (e) async {
            log.i("stopTimerPressed Started ");
            Either<TaskTimerFailure, TimerHistory> possibleFailure =
                await _taskTimerRepository.stopTaskTimer(e.taskItem);
            possibleFailure.fold((failure) {
              emit(TaskTimerState.timerFailure(failure));
            }, (success) async {
              TimerHistory timerHistory = TimerHistory(
                  id: UniqueId(),
                  taskTimeSpent:
                      FirebaseStringValue(success.taskTimeSpent?.getOrCrash()),
                  timerStopDate: FirebaseStringValue(
                      DateTime.now().toString().split('.')[0]));

              //todo : remove using the context from here!!
              e.context.read<TaskActorBloc>().add(
                  TaskActorEvent.timerHistoryChanged(timerHistory, e.taskItem));
              emit(TaskTimerState.timerStopped(e.taskItem));
            });
          },
        );
      },
    );
  }
}
