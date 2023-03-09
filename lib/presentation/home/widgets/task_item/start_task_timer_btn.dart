import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_board/application/task_timer/task_timer_bloc.dart';
import 'package:todo_board/domain/core/utilities/colors.dart';
import 'package:todo_board/domain/task/task_item.dart';

import '../../../../main.dart';

class StartTaskTimerBtn extends StatelessWidget {
  final TaskItem taskItem;

  const StartTaskTimerBtn({Key? key, required this.taskItem}) : super(key: key);

  onPressedStartTaskTimerBtn(BuildContext context) async {
    log.i("onPressedStartTaskTimerBtn Started");
    context
        .read<TaskTimerBloc>()
        .add(TaskTimerEvent.startTimerPressed(taskItem: taskItem));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskTimerBloc, TaskTimerState>(
      builder: (context, state) {
        return state.maybeMap(
          orElse: () => buildStartedTimerBtn(context),
          timerWorking: (timerWorking) => buildDisabledBtn(),
        );
      },
    );
  }

  IconButton buildStartedTimerBtn(BuildContext context) {
    return IconButton(
      onPressed: () => onPressedStartTaskTimerBtn(context),
      icon: Icon(
        Icons.timer_outlined,
        color: AppColors.greenColor4,
      ),
    );
  }

  IconButton buildDisabledBtn() {
    return IconButton(
      onPressed: null,
      icon: Icon(
        Icons.timer_outlined,
        color: AppColors.grayColor2,
      ),
    );
  }
}
