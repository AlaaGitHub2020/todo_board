import 'package:flutter/material.dart';
import 'package:todo_board/domain/task/task_item.dart';
import 'package:todo_board/presentation/home/widgets/task_item/delete_btn.dart';
import 'package:todo_board/presentation/home/widgets/task_item/edit_btn.dart';
import 'package:todo_board/presentation/home/widgets/task_item/start_task_timer_btn.dart';
import 'package:todo_board/presentation/home/widgets/task_item/task_timer_history_btn.dart';

class TaskCardControllersBtnS extends StatelessWidget {
  final TaskItem taskItem;

  const TaskCardControllersBtnS({Key? key, required this.taskItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TaskTimerHistoryBtn(taskItem: taskItem),
        StartTaskTimerBtn(taskItem: taskItem),
        EditBtn(taskItem: taskItem),
        DeleteBtn(taskItem: taskItem),
      ],
    );
  }
}
