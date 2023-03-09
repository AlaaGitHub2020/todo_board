import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_value_failure.freezed.dart';

@freezed
class TaskValueFailure<T> with _$TaskValueFailure<T> {
  const factory TaskValueFailure.invalidFirebaseStringValue({
    required T failedValue,
  }) = InvalidFirebaseStringValuee<T>;
}
