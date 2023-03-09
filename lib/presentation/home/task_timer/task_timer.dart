import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_board/application/task_timer/task_timer_bloc.dart';
import 'package:todo_board/presentation/home/task_timer/task_timer_card.dart';

class TaskTimer extends StatelessWidget {
  const TaskTimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskTimerBloc, TaskTimerState>(
      builder: (context, state) {
        return state.maybeMap(
          orElse: () => Container(),
          timerWorking: (taskItemWorkingOn) =>
              TaskTimerCard(taskItem: taskItemWorkingOn.taskItem),
        );
      },
    );
  }
}
