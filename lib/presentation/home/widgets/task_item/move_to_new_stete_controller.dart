import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_board/application/tasks/task_actor/task_actor_bloc.dart';
import 'package:todo_board/domain/core/utilities/colors.dart';
import 'package:todo_board/domain/core/utilities/strings.dart';
import 'package:todo_board/domain/task/task_item.dart';
import 'package:todo_board/generated/l10n.dart';

import '../../../../main.dart';

class MoveToNewStateController extends StatelessWidget {
  final TaskItem taskItem;

  const MoveToNewStateController({Key? key, required this.taskItem})
      : super(key: key);

  onTapMoveToNewState(BuildContext context, TaskState moveToState) {
    log.i("moveToState.name:${moveToState.name}");

    context
        .read<TaskActorBloc>()
        .add(TaskActorEvent.moveToNewTaskStatePressed(taskItem, moveToState));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildMoveToText(context),
        buildMoveToStatesBtnS(context),
      ],
    );
  }

  Expanded buildMoveToStatesBtnS(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Row(
        children: [
          (taskItem.taskState?.getOrCrash() == TaskState.toDo.name)
              ? Container()
              : buildTaskStateInkWell(
                  context: context,
                  taskStateText: TaskState.toDo.name,
                  textColor: AppColors.blackColor1,
                  moveToState: TaskState.toDo,
                ),
          (taskItem.taskState?.getOrCrash() == TaskState.inProgress.name)
              ? Container()
              : buildTaskStateInkWell(
                  context: context,
                  taskStateText: TaskState.inProgress.name,
                  textColor: AppColors.orangeColor1,
                  moveToState: TaskState.inProgress,
                ),
          (taskItem.taskState?.getOrCrash() == TaskState.done.name)
              ? Container()
              : buildTaskStateInkWell(
                  context: context,
                  taskStateText: TaskState.done.name,
                  textColor: AppColors.greenColor2,
                  moveToState: TaskState.done,
                ),
        ],
      ),
    );
  }

  Expanded buildMoveToText(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Text(S.of(context).moveTo,
          style: Theme.of(context).textTheme.displayMedium),
    );
  }

  Expanded buildTaskStateInkWell(
      {required BuildContext context,
      required String taskStateText,
      required Color textColor,
      required TaskState moveToState}) {
    return Expanded(
      flex: 2,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 15, bottom: 15, left: 4, right: 4),
          child: Text(
            taskStateText,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: textColor, fontWeight: FontWeight.bold, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
        onTap: () => onTapMoveToNewState(context, moveToState),
      ),
    );
  }
}
