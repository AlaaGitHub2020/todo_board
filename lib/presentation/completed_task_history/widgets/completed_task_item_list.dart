import 'package:flutter/material.dart';
import 'package:todo_board/domain/task/task_item.dart';
import 'package:todo_board/presentation/completed_task_history/widgets/completed_task_item_card_details.dart';
import 'package:todo_board/presentation/drawer/export_to_csv_btn.dart';
import 'package:todo_board/presentation/home/widgets/widgets/tasks_list_card.dart';

class CompletedTaskItemList extends StatefulWidget {
  final String listName;
  final String tasksCounter;
  final List<TaskItem> tasksList;

  const CompletedTaskItemList({
    super.key,
    required this.listName,
    required this.tasksCounter,
    required this.tasksList,
  });

  @override
  State<CompletedTaskItemList> createState() => _CompletedTaskItemListState();
}

class _CompletedTaskItemListState extends State<CompletedTaskItemList> {
  final _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TasksListCard(
      tasksListTitle: widget.listName,
      tasksCounter: widget.tasksCounter,
      tasksListChild: Scrollbar(
        thumbVisibility: true,
        controller: _controller,
        child: Column(
          children: [
            ExportToCSVBtn(listOfItems: widget.tasksList),
            ListView.builder(
              controller: _controller,
              primary: false,
              shrinkWrap: true,
              itemCount: widget.tasksList.length,
              itemBuilder: (context, i) {
                return CompletedTaskItemCardDetails(
                  taskItem: widget.tasksList[i],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
