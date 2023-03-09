part of 'create_new_task_form_bloc.dart';

@freezed
class CreateNewTaskFormEvent with _$CreateNewTaskFormEvent {
  const factory CreateNewTaskFormEvent.initialized(
      Option<TaskItem> initialTaskOption) = _Initialized;

  const factory CreateNewTaskFormEvent.taskNameChanged(String taskNameString) =
      _TaskNameChanged;

  const factory CreateNewTaskFormEvent.taskDescriptionChanged(
      String taskDescriptionString) = _TaskDescriptionChanged;

  const factory CreateNewTaskFormEvent.taskPriorityChanged(
      String taskPriorityString) = _TaskPriorityChanged;

  const factory CreateNewTaskFormEvent.taskStateChanged(
      String taskStateString) = _TaskStateChanged;

  const factory CreateNewTaskFormEvent.taskDateCompletedChanged(
      String taskDateCompletedString) = _TaskDateCompletedChanged;

  const factory CreateNewTaskFormEvent.createdAtChanged(
      String createdAtString) = _CreatedAtChanged;

  const factory CreateNewTaskFormEvent.savedPressed() = _SavedPressed;
}
