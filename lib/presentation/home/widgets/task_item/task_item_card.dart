import 'package:flutter/material.dart';
import 'package:todo_board/domain/core/utilities/colors.dart';
import 'package:todo_board/domain/core/utilities/strings.dart';
import 'package:todo_board/domain/task/task_item.dart';
import 'package:todo_board/generated/l10n.dart';
import 'package:todo_board/presentation/home/widgets/task_item/change_task_priority_controllers.dart';
import 'package:todo_board/presentation/home/widgets/task_item/move_to_new_stete_controller.dart';
import 'package:todo_board/presentation/home/widgets/task_item/task_card_controllers_btns.dart';

class TaskItemCard extends StatelessWidget {
  final TaskItem taskItem;

  const TaskItemCard({
    Key? key,
    required this.taskItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: (taskItem.taskState?.getOrCrash() == TaskState.toDo.name)
          ? AppColors.grayColor1.withOpacity(0.5)
          : (taskItem.taskState?.getOrCrash() == TaskState.inProgress.name)
              ? AppColors.orangeColor1.withOpacity(0.5)
              : AppColors.greenColor2.withOpacity(0.5),
      elevation: 10,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TaskCardControllersBtnS(taskItem: taskItem),
            buildSizedBox(),
            buildTaskItemIdText(context),
            buildSizedBox(),
            ChangeTaskPriorityControllers(taskItem: taskItem),
            buildSizedBox(),
            buildTaskNameText(context),
            buildSizedBox(),
            buildDescriptionText(context),
            buildSizedBox(),
            MoveToNewStateController(taskItem: taskItem),
            const SizedBox(height: 25),
            buildCreatedAtText(context),
            (taskItem.taskState?.getOrCrash() == TaskState.done.name)
                ? buildSizedBox()
                : Container(),
            (taskItem.taskState?.getOrCrash() == TaskState.done.name)
                ? buildTaskCompletedAtText(context)
                : Container(),
          ],
        ),
      ),
    );
  }

  SizedBox buildSizedBox() => const SizedBox(height: 10);

  Text buildTaskItemIdText(BuildContext context) {
    return Text(
      "${Strings.cId}${taskItem.id.getOrCrash()}",
      style: Theme.of(context).textTheme.displayMedium,
    );
  }

  Text buildTaskNameText(BuildContext context) {
    return Text(
      "${S.of(context).task}${taskItem.taskName?.getOrCrash()}",
      style: Theme.of(context).textTheme.displayMedium,
    );
  }

  Text buildDescriptionText(BuildContext context) {
    return Text(
      "${S.of(context).description} ${taskItem.taskDescription?.getOrCrash()}",
      style: Theme.of(context).textTheme.displayMedium,
    );
  }

  Text buildTaskCompletedAtText(BuildContext context) {
    return Text(
      "${S.of(context).taskCompletedAt} ${taskItem.taskDateCompleted?.getOrCrash()?.split('.')[0]}",
      style: Theme.of(context).textTheme.labelSmall,
    );
  }

  Text buildCreatedAtText(BuildContext context) {
    return Text(
      "${S.of(context).createdAt} ${taskItem.createdAt?.getOrCrash()?.split('.')[0]}",
      style: Theme.of(context).textTheme.labelSmall,
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
      border: Border(
        left: BorderSide(
          color: (taskItem.taskPriority?.getOrCrash() == TaskPriority.high.name)
              ? AppColors.errorColor
              : (taskItem.taskPriority?.getOrCrash() ==
                      TaskPriority.medium.name)
                  ? AppColors.yellowColor1
                  : AppColors.whiteColor1,
          width: 10,
        ),
      ),
    );
  }
}
