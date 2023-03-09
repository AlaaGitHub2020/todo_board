import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_board/application/tasks/create_new_task_form/create_new_task_form_bloc.dart';
import 'package:todo_board/domain/core/utilities/colors.dart';
import 'package:todo_board/domain/core/utilities/strings.dart';
import 'package:todo_board/generated/l10n.dart';
import 'package:todo_board/presentation/new_task/widgets/task_priority_dropdown_menu.dart';

class SelectTaskPriorityRowControllers extends StatelessWidget {
  const SelectTaskPriorityRowControllers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildSelectTaskPriorityText(context),
        Row(
          children: [
            buildPriorityIcon(),
            const SizedBox(width: 24),
            const TaskPriorityDropdownMenu(),
          ],
        ),
      ],
    );
  }

  Text buildSelectTaskPriorityText(BuildContext context) {
    return Text(
      S.of(context).selectTaskPriority,
      style: Theme.of(context).textTheme.displayMedium,
    );
  }

  BlocBuilder<CreateNewTaskFormBloc, CreateNewTaskFormState>
      buildPriorityIcon() {
    return BlocBuilder<CreateNewTaskFormBloc, CreateNewTaskFormState>(
      builder: (context, state) {
        return Icon(
          Icons.flag,
          color: (state.task.taskPriority?.getOrCrash() ==
                  TaskPriority.medium.name)
              ? AppColors.yellowColor1
              : (state.task.taskPriority?.getOrCrash() == TaskPriority.low.name)
                  ? AppColors.whiteColor1
                  : (state.task.taskPriority?.getOrCrash() ==
                          TaskPriority.high.name)
                      ? AppColors.errorColor
                      : AppColors.grayColor2,
        );
      },
    );
  }
}
