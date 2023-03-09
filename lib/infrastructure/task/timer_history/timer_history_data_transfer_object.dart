import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_board/domain/core/utilities/logger/simple_log_printer.dart';
import 'package:todo_board/domain/core/value_objects.dart';
import 'package:todo_board/domain/task/timer_history/timer_history.dart';

part 'timer_history_data_transfer_object.freezed.dart';

part 'timer_history_data_transfer_object.g.dart';

///Dto: data transfer object

@freezed
class TimerHistoryDto with _$TimerHistoryDto {
  const factory TimerHistoryDto({
    @JsonKey(ignore: true) String? id,
    String? taskTimeSpent,
    String? timerStopDate,
  }) = _TimerHistoryDto;

  factory TimerHistoryDto.fromDomain(TimerHistory timerHistory) {
    return TimerHistoryDto(
      id: timerHistory.id.getOrCrash(),
      taskTimeSpent: timerHistory.taskTimeSpent!.getOrCrash(),
      timerStopDate: timerHistory.timerStopDate!.getOrCrash(),
    );
  }

  factory TimerHistoryDto.fromJson(Map<String, dynamic> json) =>
      _$TimerHistoryDtoFromJson(json);

  factory TimerHistoryDto.fromFireStore(DocumentSnapshot doc) {
    try {
      final log = getLogger();
      log.i("doc.data():${doc.data()}");
      Map<String, dynamic> jsonFromFireStoreObject =
          doc.data() as Map<String, dynamic>;
      return TimerHistoryDto.fromJson(jsonFromFireStoreObject)
          .copyWith(id: doc.id);
    } catch (e) {
      final log = getLogger();
      log.e("Error:$e");
      Map<String, dynamic> emptyMap = {};
      return TimerHistoryDto.fromJson(emptyMap);
    }
  }
}

extension TimerHistoryDtoX on TimerHistoryDto {
  TimerHistory toDomain() {
    return TimerHistory(
      id: UniqueId.fromUniqueString(id!),
      taskTimeSpent: FirebaseStringValue(taskTimeSpent),
      timerStopDate: FirebaseStringValue(timerStopDate),
    );
  }
}
