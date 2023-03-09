import 'package:flutter/material.dart';
import 'package:todo_board/domain/core/utilities/colors.dart';
import 'package:todo_board/domain/core/utilities/strings.dart';
import 'package:todo_board/domain/task/task_item.dart';
import 'package:todo_board/generated/l10n.dart';
import 'package:todo_board/presentation/task_timer_history/widgets/task_timer_history_list.dart';

class TaskTimerHistoryBody extends StatelessWidget {
  final TaskItem taskItem;

  const TaskTimerHistoryBody({Key? key, required this.taskItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: buildAppBar(context),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                (taskItem.taskState?.getOrCrash() == TaskState.done.name)
                    ? Column(
                        children: [
                          buildTaskDateCompletedText(context),
                          buildSizedBox(),
                        ],
                      )
                    : buildTaskIsNotCompletedYetText(context),
                buildSizedBox(),
                buildTaskNameText(context),
                buildSizedBox(),
                const TaskTimerHistoryList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text buildTaskIsNotCompletedYetText(BuildContext context) {
    return Text(
      S.of(context).taskIsNotCompletedYet,
      style: Theme.of(context).textTheme.titleMedium,
      textAlign: TextAlign.center,
    );
  }

  Text buildTaskDateCompletedText(BuildContext context) {
    return Text(
      "${S.of(context).taskCompletedAt} ${taskItem.taskDateCompleted?.getOrCrash()?.split('.')[0]}",
      style: Theme.of(context).textTheme.titleMedium,
      textAlign: TextAlign.center,
    );
  }

  Text buildTaskNameText(BuildContext context) {
    return Text(
      "${S.of(context).youSpentThisTimeslotsOnTheTask}${taskItem.taskName?.getOrCrash()}",
      style: Theme.of(context).textTheme.titleMedium,
      textAlign: TextAlign.center,
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        taskItem.taskName?.getOrCrash() ?? '',
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: AppColors.whiteColor1),
      ),
      centerTitle: false,
    );
  }

  SizedBox buildSizedBox() => const SizedBox(height: 25);
}
