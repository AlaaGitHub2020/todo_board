import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/collection.dart';
import 'package:todo_board/application/tasks/task_actor/task_actor_bloc.dart';
import 'package:todo_board/application/tasks/task_timer_history_watcher/task_timer_history_watcher_bloc.dart';
import 'package:todo_board/domain/task/task_item.dart';
import 'package:todo_board/domain/task/timer_history/timer_history.dart';
import 'package:todo_board/generated/l10n.dart';
import 'package:todo_board/presentation/core/loading.dart';
import 'package:todo_board/presentation/drawer/export_to_csv_btn.dart';
import 'package:todo_board/presentation/task_timer_history/widgets/delete_timer_history_btn.dart';

class TaskTimerHistoryList extends StatelessWidget {
  final TaskItem taskItem;

  const TaskTimerHistoryList({Key? key, required this.taskItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskActorBloc, TaskActorState>(
      builder: (context, state) {
        return state.maybeMap(
          orElse: () => buildTheList(),
          actionInProgress: (_) => const Loading(fullScreen: true),
          deleteTaskFailure: (_) => buildFailureHappened(context),
          moveToNewTaskStateFailure: (_) => buildFailureHappened(context),
          changeTaskPriorityFailure: (_) => buildFailureHappened(context),
          changedTimerHistoryFailure: (_) => buildFailureHappened(context),
        );
      },
    );
  }

  BlocBuilder<TaskTimerHistoryWatcherBloc, TaskTimerHistoryWatcherState>
      buildTheList() {
    return BlocBuilder<TaskTimerHistoryWatcherBloc,
        TaskTimerHistoryWatcherState>(
      builder: (context, tasksWatcherState) {
        return tasksWatcherState.map(
            initial: (_) => Container(),
            loadInProgress: (_) => const Loading(),
            loadSuccess: (success) {
              if (success.timerHistoryList.size == 0) {
                return Text(
                  S.of(context).youDidNotSpendAnyTimeOnThisTaskYet,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                );
              }
              return Column(
                children: [
                  buildExportDeleteRow(context, success.timerHistoryList),
                  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: success.timerHistoryList.size,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${S.of(context).youSpend}${success.timerHistoryList[index].taskTimeSpent?.getOrCrash()}${S.of(context).at}${success.timerHistoryList[index].timerStopDate?.getOrCrash()}",
                          style: Theme.of(context).textTheme.displayMedium,
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
                ],
              );
            },
            loadFailure: (failure) {
              return Center(child: Text("${failure.taskFailure}"));
            });
      },
    );
  }

  Center buildFailureHappened(BuildContext context) => Center(
        child: Text(S.of(context).oopsErrorHappened),
      );

  Row buildExportDeleteRow(
      BuildContext context, KtList<TimerHistory> timerHistoryList) {
    return Row(
      children: [
        Expanded(
          child: ExportToCSVBtn(listOfTimerHistory: timerHistoryList),
        ),
        DeleteTimerHistoryBtn(taskItem: taskItem),
      ],
    );
  }
}
