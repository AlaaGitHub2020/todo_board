import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:todo_board/domain/core/utilities/helper.dart';
import 'package:todo_board/domain/core/utilities/strings.dart';
import 'package:todo_board/domain/task/task_item.dart';
import 'package:todo_board/domain/task/timer_history/timer_history.dart';
import 'package:todo_board/generated/l10n.dart';

import '../../../main.dart';

class ExportToCSVBtn extends StatelessWidget {
  final List<TaskItem>? listOfItems;
  final KtList<TimerHistory>? listOfTimerHistory;

  const ExportToCSVBtn({Key? key, this.listOfItems, this.listOfTimerHistory})
      : super(key: key);

  onPressedExportToCSVBtn(BuildContext context) async {
    log.i("onPressedExportToCSVBtn Started");
    List<String> listOfItemsHeader = [
      Strings.cID,
      Strings.cTaskName,
      Strings.cTaskDescription,
      Strings.cTaskState,
      Strings.cTaskPriority,
      Strings.cCreatedAt,
      Strings.cTaskDateCompleted
    ];

    List<String> listOfTimerHistoryHeader = [
      Strings.cID,
      Strings.cTaskTimeSpent,
      Strings.cTimerStopDate
    ];
    if (listOfItems != null) {
      Helper().exportListOfItemsToCSV(
          listOfItems: listOfItems, listOfItemsHeader: listOfItemsHeader);
    }
    if (listOfTimerHistory != null) {
      Helper().exportTheListOfTimerHistoryCSVFile(
        listOfTimerHistory: listOfTimerHistory,
        listOfTimerHistoryHeader: listOfTimerHistoryHeader,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressedExportToCSVBtn(context),
      child: Text(
        (listOfItems != null)
            ? S.of(context).exportToCSV
            : S.of(context).exportTimerHistoryToCSV,
        style: Theme.of(context).textTheme.titleMedium,
        textAlign: TextAlign.center,
        maxLines: 2,
      ),
    );
  }
}
