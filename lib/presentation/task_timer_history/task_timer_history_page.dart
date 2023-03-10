import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_board/application/tasks/task_actor/task_actor_bloc.dart';
import 'package:todo_board/application/tasks/task_timer_history_watcher/task_timer_history_watcher_bloc.dart';
import 'package:todo_board/domain/task/task_item.dart';
import 'package:todo_board/injection.dart';
import 'package:todo_board/presentation/task_timer_history/widgets/task_timer_history_body.dart';

class TaskTimerHistoryPage extends StatelessWidget {
  final TaskItem taskItem;

  const TaskTimerHistoryPage({Key? key, required this.taskItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskTimerHistoryWatcherBloc>(
          create: (context) => getIt<TaskTimerHistoryWatcherBloc>()
            ..add(
                TaskTimerHistoryWatcherEvent.watchUserTasksTimerHistoryStarted(
                    taskItem)),
        ),
        BlocProvider<TaskActorBloc>(
          create: (context) => getIt<TaskActorBloc>(),
        ),
      ],
      child: TaskTimerHistoryBody(taskItem: taskItem),
    );
  }
}
