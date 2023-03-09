import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:todo_board/domain/task/task_item.dart';
import 'package:todo_board/main.dart';
import 'package:todo_board/presentation/routes/router.gr.dart';

class EditBtn extends StatelessWidget {
  final TaskItem taskItem;

  const EditBtn({Key? key, required this.taskItem}) : super(key: key);

  onPressedEditBtn(BuildContext context) {
    log.i("onPressedEditBtn Started: $taskItem");
    context.router.push(NewTaskRoute(editedTask: taskItem));
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => onPressedEditBtn(context),
        icon: const Icon(Icons.edit));
  }
}
