import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_board/application/tasks/task_actor/task_actor_bloc.dart';
import 'package:todo_board/domain/core/utilities/colors.dart';
import 'package:todo_board/domain/task/task_item.dart';
import 'package:todo_board/generated/l10n.dart';
import 'package:todo_board/main.dart';
import 'package:todo_board/presentation/home/widgets/task_item/cancel_btn.dart';

class DeleteBtn extends StatelessWidget {
  final TaskItem taskItem;

  const DeleteBtn({Key? key, required this.taskItem}) : super(key: key);

  onPressedDeleteBtn(BuildContext context) {
    log.i("onPressedDeleteBtn Started: $taskItem");
    _showDeletionDialog(context);
  }

  onPressedAlertDialogDeleteBtn(BuildContext context) {
    log.i("onPressedAlertDialogDeleteBtn Started");
    context
        .read<TaskActorBloc>()
        .add(TaskActorEvent.deleteTaskPressed(taskItem));
    context.router.pop();
  }

  _showDeletionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context1) {
        return AlertDialog(
          title: deleteTaskText(context),
          content: buildWantToDeleteText(context),
          actions: [
            const CancelBtn(),
            buildDeleteBtn(context),
          ],
        );
      },
    );
  }

  Text deleteTaskText(BuildContext context) {
    return Text(
      S.of(context).deleteTask,
      style: Theme.of(context).textTheme.displayMedium,
    );
  }

  ElevatedButton buildDeleteBtn(BuildContext context) {
    return ElevatedButton(
        onPressed: () => onPressedAlertDialogDeleteBtn(context),
        child: Text(S.of(context).delete));
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onPressedDeleteBtn(context),
      icon: const Icon(
        Icons.delete,
        color: AppColors.errorColor,
      ),
    );
  }

  Text buildWantToDeleteText(BuildContext context) {
    return Text(
      S.of(context).areYouSure(taskItem.taskName?.getOrCrash() ?? ""),
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
