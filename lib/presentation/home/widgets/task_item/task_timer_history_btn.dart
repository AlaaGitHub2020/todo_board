import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:todo_board/domain/task/task_item.dart';
import 'package:todo_board/presentation/routes/router.gr.dart';

import '../../../../main.dart';

class TaskTimerHistoryBtn extends StatelessWidget {
  final TaskItem taskItem;

  const TaskTimerHistoryBtn({Key? key, required this.taskItem})
      : super(key: key);

  onPressedTaskTimerHistoryBtn(BuildContext context) {
    log.i("onPressedTaskTimerHistoryBtn Started");

    context.router.push(TaskTimerHistoryRoute(taskItem: taskItem));
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => onPressedTaskTimerHistoryBtn(context),
        icon: const Icon(Icons.history));
  }
}
