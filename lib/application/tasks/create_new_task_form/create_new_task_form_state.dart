part of 'create_new_task_form_bloc.dart';

@freezed
class CreateNewTaskFormState with _$CreateNewTaskFormState {
  const factory CreateNewTaskFormState({
    required TaskItem task,
    required AutovalidateMode showErrorMessages,
    required bool isEditing,
    required bool isSaving,
    required Option<Either<TaskFailure, Unit>> saveFailureOrSuccessOption,
  }) = _CreateNewTaskFormState;

  factory CreateNewTaskFormState.initial() => CreateNewTaskFormState(
        task: TaskItem.empty(),
        showErrorMessages: AutovalidateMode.disabled,
        isEditing: false,
        isSaving: false,
        saveFailureOrSuccessOption: none(),
      );
}
