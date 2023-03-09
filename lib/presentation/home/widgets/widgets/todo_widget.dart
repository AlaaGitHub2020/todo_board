import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_board/application/tasks/tasks_watcher/tasks_watcher_bloc.dart';
import 'package:todo_board/domain/core/utilities/strings.dart';
import 'package:todo_board/domain/task/task_item.dart';
import 'package:todo_board/presentation/core/loading.dart';
import 'package:todo_board/presentation/home/widgets/widgets/items_list.dart';

class ToDoWidget extends StatelessWidget {
  const ToDoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<TasksWatcherBloc, TasksWatcherState>(
        builder: (context, tasksWatcherState) {
          return tasksWatcherState.map(
              initial: (_) => Container(),
              loadInProgress: (_) => const Loading(),
              loadSuccess: (success) {
                List<TaskItem> toDoList = [];
                for (int i = 0; i < success.tasksList.size; i++) {
                  if ("${success.tasksList[i].taskState?.getOrCrash()}" ==
                      TaskState.toDo.name) {
                    toDoList.add(success.tasksList[i]);
                  }
                }
                return ItemsList(
                  listName: Strings.cToDo,
                  tasksCounter: toDoList.length.toString(),
                  tasksList: toDoList,
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
