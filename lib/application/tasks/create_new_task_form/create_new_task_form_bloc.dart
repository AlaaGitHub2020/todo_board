import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_board/domain/core/utilities/logger/simple_log_printer.dart';
import 'package:todo_board/domain/core/value_objects.dart';
import 'package:todo_board/domain/task/i_task_item_repository.dart';
import 'package:todo_board/domain/task/task_failure.dart';
import 'package:todo_board/domain/task/task_item.dart';

part 'create_new_task_form_bloc.freezed.dart';

part 'create_new_task_form_event.dart';

part 'create_new_task_form_state.dart';

@injectable
class CreateNewTaskFormBloc
    extends Bloc<CreateNewTaskFormEvent, CreateNewTaskFormState> {
  final ITaskItemRepository _taskItemRepository;
  final log = getLogger();

  CreateNewTaskFormBloc(this._taskItemRepository)
      : super(CreateNewTaskFormState.initial()) {
    on<CreateNewTaskFormEvent>(
      (event, emit) async {
        await event.map(
          initialized: (e) async {
            log.i("initialized started");
            emit(
              e.initialTaskOption.fold(
                () => state,
                (initialTask) =>
                    state.copyWith(task: initialTask, isEditing: true),
              ),
            );
          },
          taskNameChanged: (e) async {
            log.i("taskNameChanged started");
            emit(
              state.copyWith(
                task: state.task.copyWith(
                  taskName: FirebaseStringValue(e.taskNameString),
                ),
                saveFailureOrSuccessOption: none(),
              ),
            );
          },
          taskDescriptionChanged: (e) async {
            log.i("taskDescriptionChanged started");
            emit(
              state.copyWith(
                task: state.task.copyWith(
                    taskDescription:
                        FirebaseStringValue(e.taskDescriptionString)),
                saveFailureOrSuccessOption: none(),
              ),
            );
          },
          taskPriorityChanged: (e) async {
            log.i("taskPriorityChanged started");
            emit(
              state.copyWith(
                task: state.task.copyWith(
                  taskPriority: FirebaseStringValue(e.taskPriorityString),
                ),
                saveFailureOrSuccessOption: none(),
              ),
            );
          },
          taskStateChanged: (e) async {
            log.i("taskStateChanged started");
            emit(
              state.copyWith(
                task: state.task.copyWith(
                    taskState: FirebaseStringValue(e.taskStateString)),
                saveFailureOrSuccessOption: none(),
              ),
            );
          },
          createdAtChanged: (e) async {
            log.i("createdAtChanged started");
            emit(
              state.copyWith(
                task: state.task.copyWith(
                    createdAt: FirebaseStringValue(e.createdAtString)),
                saveFailureOrSuccessOption: none(),
              ),
            );
          },
          taskDateCompletedChanged: (e) async {
            log.i("taskDateCompletedChanged started");
            emit(
              state.copyWith(
                task: state.task.copyWith(
                    taskDateCompleted:
                        FirebaseStringValue(e.taskDateCompletedString)),
                saveFailureOrSuccessOption: none(),
              ),
            );
          },
          savedPressed: (e) async {
            log.i("savedPressed started");
            final bool isTaskBodyValid =
                ((state.task.taskName?.getOrCrash() != '') &&
                    (state.task.taskName?.getOrCrash() != null));
            if (isTaskBodyValid) {
              log.i("isTaskBodyValid $isTaskBodyValid");
              CreateNewTaskFormState taskFormState = state.copyWith(
                isSaving: true,
                saveFailureOrSuccessOption: none(),
              );
              emit(taskFormState);

              Either<TaskFailure, Unit> failureOrSuccess;
              failureOrSuccess = state.isEditing
                  ? await _taskItemRepository.updateUserTask(state.task)
                  : await _taskItemRepository.createNewUserTask(state.task);
              taskFormState = state.copyWith(
                isSaving: false,
                showErrorMessages: AutovalidateMode.always,
                saveFailureOrSuccessOption: optionOf(failureOrSuccess),
              );

              emit(taskFormState);
            } else {
              log.i("isTaskBodyValid $isTaskBodyValid");
              emit(
                state.copyWith(
                  isSaving: false,
                  showErrorMessages: AutovalidateMode.always,
                  saveFailureOrSuccessOption: optionOf(
                      left(const TaskFailure.taskIsEmptyPleaseFillItFirst())),
                ),
              );
            }
          },
        );
      },
    );
  }
}
