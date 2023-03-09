import 'package:flutter/material.dart';
import 'package:todo_board/generated/l10n.dart';

class TaskNameText extends StatelessWidget {
  const TaskNameText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      S.of(context).taskName,
      style: Theme.of(context).textTheme.displayMedium,
    );
  }
}
