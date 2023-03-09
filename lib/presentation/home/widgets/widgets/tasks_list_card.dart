import 'package:flutter/material.dart';
import 'package:todo_board/generated/l10n.dart';

class TasksListCard extends StatelessWidget {
  final String tasksListTitle;
  final String tasksCounter;
  final Widget tasksListChild;

  const TasksListCard({
    Key? key,
    required this.tasksListTitle,
    required this.tasksCounter,
    required this.tasksListChild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildSizedBox(),
            buildTitle(context),
            buildSizedBox(),
            tasksListChild,
          ],
        ),
      ),
    );
  }

  SizedBox buildSizedBox() => const SizedBox(height: 8);

  Row buildTitle(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Text(
          tasksListTitle,
          style: Theme.of(context).textTheme.titleMedium,
        )),
        const SizedBox(width: 8),
        Text(
          "$tasksCounter ${S.of(context).task1}",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
