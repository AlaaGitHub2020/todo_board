import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_board/application/tasks/tasks_watcher/tasks_watcher_bloc.dart';
import 'package:todo_board/domain/task/task_failure.dart';
import 'package:todo_board/generated/l10n.dart';
import 'package:todo_board/presentation/completed_task_history/widgets/completed_tasks_list.dart';
import 'package:todo_board/presentation/core/loading.dart';

class CompletedTaskHistoryBody extends StatelessWidget {
  const CompletedTaskHistoryBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksWatcherBloc, TasksWatcherState>(
      builder: (context, state) {
        return state.map(
            initial: (_) => Container(),
            loadInProgress: (_) => const Loading(),
            loadSuccess: (state) {
              if (state.tasksList.size == 0) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Center(child: Text(S.of(context).noCompletedTasksYet)),
                );
              }
              return const CompletedTasksList();
            },
            loadFailure: (state) {
              if (state.taskFailure == const TaskFailure.unexpected()) {
                return const Loading();
              } else {
                return Center(child: Text("${state.taskFailure}"));
              }
            });
      },
    );
  }
}
