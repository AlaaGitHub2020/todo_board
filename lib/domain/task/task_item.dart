import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_board/domain/core/entity.dart';
import 'package:todo_board/domain/core/failures.dart';
import 'package:todo_board/domain/core/utilities/strings.dart';
import 'package:todo_board/domain/core/value_objects.dart';

part 'task_item.freezed.dart';

@freezed
class TaskItem with _$TaskItem implements IEntity {
  const factory TaskItem({
    required UniqueId id,
    FirebaseStringValue? createdAt,
    FirebaseStringValue? taskDateCompleted,
    FirebaseStringValue? taskState,
    FirebaseStringValue? taskName,
    FirebaseStringValue? taskDescription,
    FirebaseStringValue? taskPriority,
  }) = _TaskItem;

  factory TaskItem.empty() => TaskItem(
        id: UniqueId(),
        createdAt: FirebaseStringValue(DateTime.now().toString()),
        taskDateCompleted: FirebaseStringValue(''),
        taskState: FirebaseStringValue(TaskState.toDo.name),
        taskName: FirebaseStringValue(''),
        taskDescription: FirebaseStringValue(''),
        taskPriority: FirebaseStringValue(TaskPriority.medium.name),
      );
}

extension TaskItemX on TaskItem {
  Option<ValueFailure<dynamic>>? get failureOption {
    return createdAt?.failureOrUnit
        .andThen(taskDateCompleted!.failureOrUnit)
        .andThen(taskState!.failureOrUnit)
        .andThen(taskName!.failureOrUnit)
        .andThen(taskDescription!.failureOrUnit)
        .andThen(taskPriority!.failureOrUnit)
        .fold((failure) => some(failure), (_) => none());
  }
}
