import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_board/application/tasks/tasks_watcher/tasks_watcher_bloc.dart';
import 'package:todo_board/domain/core/utilities/strings.dart';
import 'package:todo_board/domain/task/task_item.dart';
import 'package:todo_board/presentation/completed_task_history/widgets/completed_task_item_list.dart';
import 'package:todo_board/presentation/core/loading.dart';

class CompletedTasksList extends StatelessWidget {
  const CompletedTasksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      primary: true,
      shrinkWrap: true,
      slivers: [
        SliverToBoxAdapter(
          child: BlocBuilder<TasksWatcherBloc, TasksWatcherState>(
            builder: (context, tasksWatcherState) {
              return tasksWatcherState.map(
                  initial: (_) => Container(),
                  loadInProgress: (_) => const Loading(fullScreen: true),
                  loadSuccess: (success) {
                    List<TaskItem> doneList = [];
                    for (int i = 0; i < success.tasksList.size; i++) {
                      if ("${success.tasksList[i].taskState?.getOrCrash()}" ==
                          TaskState.done.name) {
                        doneList.add(success.tasksList[i]);
                      }
                    }
                    return CompletedTaskItemList(
                      listName: Strings.cCompletedTasks,
                      tasksCounter: doneList.length.toString(),
                      tasksList: doneList,
                    );
                  },
                  loadFailure: (failure) {
                    return Center(child: Text("${failure.taskFailure}"));
                  });
            },
          ),
        ),
      ],
    );
  }
}
