import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_board/application/tasks/tasks_watcher/tasks_watcher_bloc.dart';
import 'package:todo_board/domain/core/utilities/strings.dart';
import 'package:todo_board/domain/task/task_item.dart';
import 'package:todo_board/presentation/core/loading.dart';
import 'package:todo_board/presentation/home/widgets/widgets/items_list.dart';

class InProgressWidget extends StatelessWidget {
  const InProgressWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<TasksWatcherBloc, TasksWatcherState>(
        builder: (context, tasksWatcherState) {
          return tasksWatcherState.map(
              initial: (_) => Container(),
              loadInProgress: (_) => const Loading(),
              loadSuccess: (success) {
                List<TaskItem> inProgressList = [];
                for (int i = 0; i < success.tasksList.size; i++) {
                  if ("${success.tasksList[i].taskState?.getOrCrash()}" ==
                      TaskState.inProgress.name) {
                    inProgressList.add(success.tasksList[i]);
                  }
                }
                return ItemsList(
                  listName: Strings.cInProgress,
                  tasksCounter: inProgressList.length.toString(),
                  tasksList: inProgressList,
                );
              },
              loadFailure: (failure) {
                return Center(child: Text("${failure.taskFailure}"));
              });
        },
      ),
    );
  }
}
