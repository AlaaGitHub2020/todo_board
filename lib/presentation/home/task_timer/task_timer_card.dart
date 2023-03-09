import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:todo_board/application/task_timer/task_timer_bloc.dart';
import 'package:todo_board/domain/core/utilities/colors.dart';
import 'package:todo_board/domain/task/task_item.dart';
import 'package:todo_board/domain/task_timer/i_task_timer_repository.dart';
import 'package:todo_board/injection.dart';

import '../../../main.dart';

class TaskTimerCard extends StatelessWidget {
  final TaskItem taskItem;

  const TaskTimerCard({Key? key, required this.taskItem}) : super(key: key);

  onPressedStopBtn(BuildContext context) {
    log.i("onPressedStopBtn Started");
    context.read<TaskTimerBloc>().add(
        TaskTimerEvent.stopTimerPressed(taskItem: taskItem, context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildTaskNameText(context),
            buildTimer(),
            buildStopBtn(context),
          ],
        ),
      ),
    );
  }

  StreamBuilder<int> buildTimer() {
    return StreamBuilder<int>(
      stream: getIt<ITaskTimerRepository>().stopWatchTimer.rawTime,
      initialData: getIt<ITaskTimerRepository>().stopWatchTimer.rawTime.value,
      builder: (context, snap) {
        final value = snap.data!;
        final displayTime = StopWatchTimer.getDisplayTime(value, hours: true);
        return Text(
          displayTime.split('.')[0],
          style: Theme.of(context).textTheme.titleLarge,
        );
      },
    );
  }

  IconButton buildStopBtn(BuildContext context) {
    return IconButton(
        onPressed: () => onPressedStopBtn(context),
        icon: const Icon(
          Icons.stop,
          color: AppColors.errorColor,
        ));
  }

  Text buildTaskNameText(BuildContext context) {
    return Text(
      taskItem.taskName?.getOrCrash() ?? '',
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}
