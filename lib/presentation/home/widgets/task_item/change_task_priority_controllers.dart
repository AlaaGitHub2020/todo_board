import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_board/application/tasks/task_actor/task_actor_bloc.dart';
import 'package:todo_board/domain/core/utilities/colors.dart';
import 'package:todo_board/domain/core/utilities/strings.dart';
import 'package:todo_board/domain/task/task_item.dart';
import 'package:todo_board/generated/l10n.dart';

import '../../../../main.dart';

class ChangeTaskPriorityControllers extends StatelessWidget {
  final TaskItem taskItem;

  const ChangeTaskPriorityControllers({Key? key, required this.taskItem})
      : super(key: key);

  onTapMoveToNewState(BuildContext context, TaskPriority taskPriority) {
    log.i("taskPriority.name:${taskPriority.name}");
    context
        .read<TaskActorBloc>()
        .add(TaskActorEvent.changeTaskPriorityPressed(taskItem, taskPriority));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildChangePriorityText(context),
        buildChangePriorityFlagBtnS(context),
      ],
    );
  }

  Expanded buildChangePriorityFlagBtnS(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Row(
        children: [
          (taskItem.taskPriority?.getOrCrash() == TaskPriority.high.name)
              ? Container()
              : buildPriorityInkWell(
                  context: context,
                  text: TaskPriority.high.name,
                  color: AppColors.errorColor,
                  taskPriority: TaskPriority.high,
                ),
          (taskItem.taskPriority?.getOrCrash() == TaskPriority.medium.name)
              ? Container()
              : buildPriorityInkWell(
                  context: context,
                  text: TaskPriority.medium.name,
                  color: AppColors.yellowColor1,
                  taskPriority: TaskPriority.medium,
                ),
          (taskItem.taskPriority?.getOrCrash() == TaskPriority.low.name)
              ? Container()
              : buildPriorityInkWell(
                  context: context,
                  text: TaskPriority.low.name,
                  color: AppColors.whiteColor1,
                  taskPriority: TaskPriority.low,
                ),
        ],
      ),
    );
  }

  Expanded buildChangePriorityText(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Text(S.of(context).changePriority,
          style: Theme.of(context).textTheme.displayMedium),
    );
  }

  Expanded buildPriorityInkWell(
      {required BuildContext context,
      required String text,
      required Color color,
      required TaskPriority taskPriority}) {
    return Expanded(
      flex: 1,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 15, bottom: 15, right: 4, left: 4),
          child: Icon(Icons.flag, color: color),
        ),
        onTap: () => onTapMoveToNewState(context, taskPriority),
      ),
    );
  }
}
