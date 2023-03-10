import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_board/application/tasks/task_actor/task_actor_bloc.dart';
import 'package:todo_board/domain/core/utilities/colors.dart';
import 'package:todo_board/domain/task/task_item.dart';
import 'package:todo_board/presentation/home/widgets/task_item/cancel_btn.dart';

import '../../../generated/l10n.dart';
import '../../../main.dart';

class DeleteTimerHistoryBtn extends StatelessWidget {
  final TaskItem taskItem;

  const DeleteTimerHistoryBtn({Key? key, required this.taskItem})
      : super(key: key);

  onPressedDeleteBtn(BuildContext context) {
    log.i("onPressedDeleteBtn Started");
    _showDeletionDialog(context);
  }

  onPressedAlertDialogDeleteBtn(BuildContext context) {
    log.i("onPressedAlertDialogDeleteBtn Started");

    context
        .read<TaskActorBloc>()
        .add(TaskActorEvent.deleteTimerHistoryPressed(taskItem));
    context.router.pop();
  }

  _showDeletionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context1) {
        return AlertDialog(
          title: buildDeleteTaskTimerHistoryText(context),
          content: buildAreYouSureDeleteTimerHistoryText(context),
          actions: [
            const CancelBtn(),
            ElevatedButton(
              onPressed: () => onPressedAlertDialogDeleteBtn(context),
              child: Text(S.of(context).delete),
            ),
          ],
        );
      },
    );
  }

  Text buildDeleteTaskTimerHistoryText(BuildContext context) {
    return Text(
      S.of(context).deleteTaskTimerHistory,
      style: Theme.of(context).textTheme.displayMedium,
    );
  }

  Text buildAreYouSureDeleteTimerHistoryText(BuildContext context) {
    return Text(
      S
          .of(context)
          .areYouSureDeleteTimerHistory(taskItem.taskName?.getOrCrash() ?? ""),
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => onPressedDeleteBtn(context),
        icon: const Icon(
          Icons.delete,
          color: AppColors.errorColor,
        ));
  }
}
