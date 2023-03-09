import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_board/application/task_timer/task_timer_bloc.dart';
import 'package:todo_board/application/tasks/task_actor/task_actor_bloc.dart';
import 'package:todo_board/application/tasks/tasks_watcher/tasks_watcher_bloc.dart';
import 'package:todo_board/domain/core/utilities/colors.dart';
import 'package:todo_board/generated/l10n.dart';
import 'package:todo_board/injection.dart';
import 'package:todo_board/presentation/completed_task_history/widgets/completed_task_history_body.dart';

class CompletedTaskHistoryPage extends StatelessWidget {
  const CompletedTaskHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TasksWatcherBloc>(
          create: (context) => getIt<TasksWatcherBloc>()
            ..add(const TasksWatcherEvent.watchAllTasksStarted()),
        ),
        BlocProvider<TaskTimerBloc>(
            create: (context) => getIt<TaskTimerBloc>()),
        BlocProvider<TaskActorBloc>(
          create: (context) => getIt<TaskActorBloc>(),
        ),
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: Text(
            S.of(context).completedTaskHistory,
            style: Theme.of(context).textTheme.titleLarge!
                .copyWith( color: AppColors.whiteColor1),
          ),
          centerTitle: false,
        ),
        body: const CompletedTaskHistoryBody(),
      ),
    );
  }
}
