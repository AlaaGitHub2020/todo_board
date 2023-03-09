import 'package:flutter/material.dart';
import 'package:todo_board/domain/task/task_item.dart';
import 'package:todo_board/presentation/home/widgets/task_item/task_item_card.dart';
import 'package:todo_board/presentation/home/widgets/widgets/tasks_list_card.dart';

class ItemsList extends StatefulWidget {
  final String listName;
  final String tasksCounter;
  final List<TaskItem> tasksList;

  const ItemsList({
    super.key,
    required this.listName,
    required this.tasksCounter,
    required this.tasksList,
  });

  @override
  State<ItemsList> createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
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
      tasksListChild: Container(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
        child: Scrollbar(
          thumbVisibility: true,
          controller: _controller,
          child: ListView.builder(
            controller: _controller,
            primary: false,
            shrinkWrap: true,
            itemCount: widget.tasksList.length,
            itemBuilder: (context, index) {
              return TaskItemCard(
                taskItem: widget.tasksList[index],
              );
            },
          ),
        ),
      ),
    );
  }
}
