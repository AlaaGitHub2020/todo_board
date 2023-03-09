import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_board/application/tasks/tasks_watcher/tasks_watcher_bloc.dart';
import 'package:todo_board/domain/core/utilities/strings.dart';
import 'package:todo_board/domain/task/task_failure.dart';
import 'package:todo_board/presentation/core/loading.dart';
import 'package:todo_board/presentation/home/widgets/widgets/desktop_widgets/desktop_home_body_list.dart';
import 'package:todo_board/presentation/home/widgets/widgets/movile_home_body_list.dart';
import 'package:todo_board/presentation/home/widgets/widgets/no_tasks_yet_card.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksWatcherBloc, TasksWatcherState>(
      builder: (context, state) {
        return state.map(
            initial: (_) => Container(),
            loadInProgress: (_) => const Loading(fullScreen: true),
            loadSuccess: (state) {
              if (state.tasksList.size == 0) {
                return const NoTasksYetCard();
              }
              return (MediaQuery.of(context).size.width < Strings.cMobileWidth)
                  ? const MobileHomeBodyList()
                  : const DesktopHomeBodyList();
            },
            loadFailure: (state) {
              if (state.taskFailure == const TaskFailure.unexpected()) {
                return const Loading(fullScreen: true);
              } else {
                return Center(child: Text("${state.taskFailure}"));
              }
            });
      },
    );
  }
}
