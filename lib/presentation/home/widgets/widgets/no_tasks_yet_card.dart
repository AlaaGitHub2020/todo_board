import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:todo_board/generated/l10n.dart';
import 'package:todo_board/presentation/routes/router.gr.dart';

import '../../../../main.dart';

class NoTasksYetCard extends StatelessWidget {
  const NoTasksYetCard({Key? key}) : super(key: key);

  onPressedAddNewTaskBtn(BuildContext context) {
    log.i("onPressedAddNewTaskBtn Started");
    context.router.push(NewTaskRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 15,
        child: Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildNoTasksYetText(context),
              const SizedBox(height: 15),
              buildAddNewTaskBtn(context),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton buildAddNewTaskBtn(BuildContext context) {
    return ElevatedButton(
        onPressed: () => onPressedAddNewTaskBtn(context),
        child: Text(S.of(context).addNewTask));
  }

  Text buildNoTasksYetText(BuildContext context) {
    return Text(S.of(context).noTasksYet,
        style: Theme.of(context).textTheme.headlineLarge);
  }
}
