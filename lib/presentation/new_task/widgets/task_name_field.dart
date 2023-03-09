import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todo_board/application/tasks/create_new_task_form/create_new_task_form_bloc.dart';
import 'package:todo_board/domain/core/utilities/colors.dart';
import 'package:todo_board/domain/core/utilities/logger/simple_log_printer.dart';
import 'package:todo_board/generated/l10n.dart';
import 'package:todo_board/main.dart';

class TaskNameField extends HookWidget {
  const TaskNameField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textEditingController = useTextEditingController();
    return BlocConsumer<CreateNewTaskFormBloc, CreateNewTaskFormState>(
      listenWhen: (previousState, currentState) =>
          previousState.isEditing != currentState.isEditing,
      listener: (context, state) {
        try {
          textEditingController.text = state.task.taskName?.getOrCrash() ?? "";
          log.i(" textEditingController.text:${textEditingController.text}");
        } catch (e) {
          final log = getLogger();
          log.e("ERROR:$e");
        }
      },
      builder: (context, state) {
        return TextFormField(
          controller: textEditingController,
          decoration: buildInputDecoration(context),
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(color: AppColors.blackColor1),
          onChanged: (value) => context.read<CreateNewTaskFormBloc>().add(
                CreateNewTaskFormEvent.taskNameChanged(value),
              ),
          validator: (_) => context
              .read<CreateNewTaskFormBloc>()
              .state
              .task
              .taskName
              ?.value
              .fold(
                (failure) => failure.maybeMap(
                  task: (value) => value.failure.maybeMap(
                    invalidFirebaseStringValue: (f) =>
                        S.of(context).invalidFirebaseStringValue,
                    orElse: () => null,
                  ),
                  orElse: () => null,
                ),
                (r) => null,
              ),
        );
      },
    );
  }

  InputDecoration buildInputDecoration(BuildContext context) {
    return InputDecoration(
          labelText: S.of(context).typeYourTaskName,
          counterText: "",
        );
  }
}
