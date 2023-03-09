import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_board/application/tasks/create_new_task_form/create_new_task_form_bloc.dart';
import 'package:todo_board/domain/core/utilities/strings.dart';
import 'package:todo_board/presentation/core/widgets/state_dropdown_item.dart';

import '../../../../main.dart';

class TaskStateDropdownMenu extends StatelessWidget {
  const TaskStateDropdownMenu({Key? key}) : super(key: key);

  onChangedTaskState(value, BuildContext context) {
    log.i("onChangedTaskState Started");

    context
        .read<CreateNewTaskFormBloc>()
        .add(CreateNewTaskFormEvent.taskStateChanged(value));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateNewTaskFormBloc, CreateNewTaskFormState>(
      builder: (context, state) {
        return DropdownButton(
          isExpanded: false,
          value: state.task.taskState!.getOrCrash(),
          style: Theme.of(context).textTheme.displaySmall,
          items: List<DropdownMenuItem<String>>.generate(
              TaskState.values.length,
              (int index) => buildItemState(
                  value: TaskState.values[index].name,
                  text: TaskState.values[index].name.toUpperCase()),
              growable: true),
          underline: Container(),
          onChanged: (value) => onChangedTaskState(value, context),
        );
      },
    );
  }
}
