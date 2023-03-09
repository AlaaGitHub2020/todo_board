import 'package:flutter/material.dart';
import 'package:todo_board/generated/l10n.dart';
import 'package:todo_board/presentation/new_task/widgets/task_state_dropdown_menu.dart';

class SelectTaskStateRowControllers extends StatelessWidget {
  const SelectTaskStateRowControllers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildSelectTaskStateText(context),
        const TaskStateDropdownMenu(),
      ],
    );
  }

  Text buildSelectTaskStateText(BuildContext context) {
    return Text(
      S.of(context).selectTaskState,
      style: Theme.of(context).textTheme.displayMedium,
    );
  }
}
