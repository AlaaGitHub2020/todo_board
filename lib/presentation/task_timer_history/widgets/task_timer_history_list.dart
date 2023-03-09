import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_board/application/tasks/task_timer_history_watcher/task_timer_history_watcher_bloc.dart';
import 'package:todo_board/generated/l10n.dart';
import 'package:todo_board/presentation/core/loading.dart';
import 'package:todo_board/presentation/drawer/export_to_csv_btn.dart';

class TaskTimerHistoryList extends StatelessWidget {
  const TaskTimerHistoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  ExportToCSVBtn(listOfTimerHistory: success.timerHistoryList),
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
}
