import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_board/application/tasks/create_new_task_form/create_new_task_form_bloc.dart';
import 'package:todo_board/domain/core/utilities/strings.dart';
import 'package:todo_board/presentation/core/widgets/state_dropdown_item.dart';

import '../../../../main.dart';

class TaskPriorityDropdownMenu extends StatelessWidget {
  const TaskPriorityDropdownMenu({Key? key}) : super(key: key);

  onChangedTaskPriority(value, BuildContext context) {
    log.i("onChangedTaskPriority Started");

    context
        .read<CreateNewTaskFormBloc>()
        .add(CreateNewTaskFormEvent.taskPriorityChanged(value));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateNewTaskFormBloc, CreateNewTaskFormState>(
      builder: (context, state) {
        return DropdownButton(
          isExpanded: false,
          value: state.task.taskPriority!.getOrCrash(),
          style: Theme.of(context).textTheme.displaySmall,
          items: List<DropdownMenuItem<String>>.generate(
              TaskPriority.values.length,
              (int index) => buildItemState(
                  value: TaskPriority.values[index].name,
                  text: TaskPriority.values[index].name.toUpperCase()),
              growable: true),
          underline: Container(),
          onChanged: (value) => onChangedTaskPriority(value, context),
        );
      },
    );
  }
}
