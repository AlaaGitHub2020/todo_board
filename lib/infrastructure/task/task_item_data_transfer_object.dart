import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_board/domain/core/utilities/logger/simple_log_printer.dart';
import 'package:todo_board/domain/core/value_objects.dart';
import 'package:todo_board/domain/task/task_item.dart';
import 'package:todo_board/infrastructure/core/server_timestamp_converter.dart';

part 'task_item_data_transfer_object.freezed.dart';

part 'task_item_data_transfer_object.g.dart';

///Dto: data transfer object
@freezed
class TaskItemDto with _$TaskItemDto {
  factory TaskItemDto({
    @JsonKey(ignore: true) String? id,
    String? createdAt,
    String? taskDateCompleted,
    String? taskState,
    String? taskName,
    String? taskDescription,
    String? taskPriority,
    @ServerTimestampConverter() FieldValue? serverTimeStamp,
  }) = _TaskItemDto;

  factory TaskItemDto.fromDomain(TaskItem taskItem) {
    return TaskItemDto(
      id: taskItem.id.getOrCrash(),
      createdAt: taskItem.createdAt?.getOrCrash(),
      taskDateCompleted: taskItem.taskDateCompleted?.getOrCrash(),
      taskState: taskItem.taskState?.getOrCrash(),
      taskName: taskItem.taskName?.getOrCrash(),
      taskDescription: taskItem.taskDescription?.getOrCrash(),
      taskPriority: taskItem.taskPriority?.getOrCrash(),
      serverTimeStamp: FieldValue.serverTimestamp(),
    );
  }

  factory TaskItemDto.fromJson(Map<String, dynamic> json) =>
      _$TaskItemDtoFromJson(json);

  factory TaskItemDto.fromFireStore(DocumentSnapshot doc) {
    try {
      final log = getLogger();
      log.i("doc.data():${doc.data()}");
      Map<String, dynamic> jsonFromFireStoreObject =
          doc.data() as Map<String, dynamic>;
      return TaskItemDto.fromJson(jsonFromFireStoreObject).copyWith(id: doc.id);
    } catch (e) {
      final log = getLogger();
      log.e("Error:$e");
      Map<String, dynamic> emptyMap = {};
      return TaskItemDto.fromJson(emptyMap);
    }
  }
}

extension TaskItemDtoX on TaskItemDto {
  TaskItem toDomain() {
    return TaskItem(
      id: UniqueId.fromUniqueString(id!),
      createdAt: FirebaseStringValue(createdAt),
      taskDateCompleted: FirebaseStringValue(taskDateCompleted),
      taskState: FirebaseStringValue(taskState),
      taskName: FirebaseStringValue(taskName),
      taskDescription: FirebaseStringValue(taskDescription),
      taskPriority: FirebaseStringValue(taskPriority),
    );
  }
}
