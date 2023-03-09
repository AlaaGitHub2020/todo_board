import 'package:flutter/material.dart';
import 'package:todo_board/generated/l10n.dart';

class TaskDescriptionText extends StatelessWidget {
  const TaskDescriptionText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      S.of(context).taskDescription,
      style: Theme.of(context).textTheme.displayMedium,
    );
  }
}
