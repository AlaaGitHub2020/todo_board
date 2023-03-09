import 'package:kt_dart/collection.dart';
import 'package:todo_board/domain/task/task_item.dart';
import 'package:to_csv/to_csv.dart' as exportCSV;
import 'package:todo_board/domain/task/timer_history/timer_history.dart';

import '../../../main.dart';

class Helper {
  String getTaskTimeSpentFormattedToSaveInDB(int timeInSeconds) {
    log.i("getTaskTimeSpentFormattedToSaveInDB Started");
    int hours, minutes, seconds;

    hours = timeInSeconds ~/ 3600;

    minutes = ((timeInSeconds - hours * 3600)) ~/ 60;

    seconds = timeInSeconds - (hours * 3600) - (minutes * 60);

    String hourResult =
        hours.toString().length < 2 ? "0$hours" : hours.toString();

    String minuteResult =
        minutes.toString().length < 2 ? "0$minutes" : minutes.toString();

    String secondsResult =
        seconds.toString().length < 2 ? "0$seconds" : seconds.toString();

    String result = "$hourResult:$minuteResult:$secondsResult";

    return result;
  }

  void exportListOfItemsToCSV(
      {List<TaskItem>? listOfItems, required List<String> listOfItemsHeader}) {
    log.i("exportListOfItemsToCSV Started");
    late List<List<String>> taskItemForCompletedDetailsData;

    List<String> headerRow = List.empty(growable: true);
    taskItemForCompletedDetailsData = List<List<String>>.empty(growable: true);
    for (int i = 0; i < listOfItemsHeader.length; i++) {
      headerRow.add(listOfItemsHeader[i]);
    }
    taskItemForCompletedDetailsData.add(headerRow);

    for (int i = 0; i < listOfItems!.length; i++) {
      List<String> row = List.empty(growable: true);
      row.add("${listOfItems[i].id.getOrCrash()}");
      row.add("${listOfItems[i].taskName?.getOrCrash()}");
      row.add("${listOfItems[i].taskDescription?.getOrCrash()}");
      row.add("${listOfItems[i].taskState?.getOrCrash()}");
      row.add("${listOfItems[i].taskPriority?.getOrCrash()}");
      row.add("${listOfItems[i].createdAt?.getOrCrash()}");
      row.add("${listOfItems[i].taskDateCompleted?.getOrCrash()}");
      taskItemForCompletedDetailsData.add(row);
    }

    exportCSV.myCSV(headerRow, taskItemForCompletedDetailsData);
  }

  void exportTheListOfTimerHistoryCSVFile(
      {KtList<TimerHistory>? listOfTimerHistory,
      required List<String> listOfTimerHistoryHeader}) {
    log.i("exportTheListOfTimerHistoryCSVFile Started");
    late List<List<String>> taskItemDataForTimerHistory;

    List<String> headerRow = List.empty(growable: true);
    taskItemDataForTimerHistory = List<List<String>>.empty(growable: true);
    for (int i = 0; i < listOfTimerHistoryHeader.length; i++) {
      headerRow.add(listOfTimerHistoryHeader[i]);
    }
    taskItemDataForTimerHistory.add(headerRow);

    for (int i = 0; i < listOfTimerHistory!.size; i++) {
      List<String> row = List.empty(growable: true);
      row.add("${listOfTimerHistory[i].id.getOrCrash()}");
      row.add("${listOfTimerHistory[i].taskTimeSpent?.getOrCrash()}");
      row.add("${listOfTimerHistory[i].timerStopDate?.getOrCrash()}");
      taskItemDataForTimerHistory.add(row);
    }

    exportCSV.myCSV(headerRow, taskItemDataForTimerHistory);
  }
}
