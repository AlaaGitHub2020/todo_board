import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_board/application/tasks/task_timer_history_watcher/task_timer_history_watcher_bloc.dart';
import 'package:todo_board/domain/core/utilities/colors.dart';
import 'package:todo_board/domain/core/utilities/strings.dart';
import 'package:todo_board/domain/task/task_item.dart';
import 'package:todo_board/generated/l10n.dart';
import 'package:todo_board/injection.dart';
import 'package:todo_board/presentation/completed_task_history/widgets/task_text.dart';
import 'package:todo_board/presentation/task_timer_history/widgets/task_timer_history_list.dart';

class CompletedTaskItemCardDetails extends StatelessWidget {
  final TaskItem taskItem;

  const CompletedTaskItemCardDetails({
    Key? key,
    required this.taskItem,
  }) : super(key: key);

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
      ],
      child: Card(
        elevation: 10,
        color: AppColors.greenColor4.withOpacity(0.5),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TaskText(
                  taskAttributeName: S.of(context).task,
                  taskAttributeValue: taskItem.taskName?.getOrCrash() ?? ''),
              buildSizedBox(),
              TaskText(
                  taskAttributeName: S.of(context).description,
                  taskAttributeValue:
                      taskItem.taskDescription?.getOrCrash() ?? ''),
              buildSizedBox(),
              TaskText(
                  taskAttributeName: S.of(context).createdAt,
                  taskAttributeValue:
                      taskItem.createdAt?.getOrCrash()?.split('.')[0] ?? '',
                  textStyleLabelSmall: true),
              buildSizedBox(),
              TaskText(
                  taskAttributeName: S.of(context).taskCompletedAt,
                  taskAttributeValue:
                      taskItem.taskDateCompleted?.getOrCrash()?.split('.')[0] ??
                          '',
                  textStyleLabelSmall: true),
              TaskTimerHistoryList(taskItem: taskItem),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox buildSizedBox() => const SizedBox(height: 10);

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
      border: Border(
        left: BorderSide(
          color: (taskItem.taskPriority?.getOrCrash() == TaskPriority.high.name)
              ? AppColors.errorColor
              : (taskItem.taskPriority?.getOrCrash() ==
                      TaskPriority.medium.name)
                  ? AppColors.yellowColor1
                  : AppColors.whiteColor1,
          width: 10,
        ),
      ),
    );
  }
}
