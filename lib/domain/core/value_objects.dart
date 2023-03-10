import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_board/domain/core/errors.dart';
import 'package:todo_board/domain/core/failures.dart';
import 'package:todo_board/domain/core/value_validators.dart';
import 'package:uuid/uuid.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();

  Either<ValueFailure<T?>, T?> get value;

  /// Throws [UnexpectedValueErrors] containing the [ValueFailure]
  T? getOrCrash() {
    // id = identity - same as writing (right) => right
    return value.fold((failure) => throw UnexpectedValueErrors(failure), id);
  }

  Either<ValueFailure<dynamic>, Unit> get failureOrUnit {
    return value.fold(
      (l) => left(l),
      (r) => right(unit),
    );
  }

  bool isValid() => value.isRight();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ValueObject<T> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Value($value)';
}

class UniqueId extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory UniqueId() {
    return UniqueId._(
      right(
        const Uuid().v1(),
      ),
    );
  }

  factory UniqueId.fromUniqueString(String uniqueId) {
    return UniqueId._(
      right(uniqueId),
    );
  }

  const UniqueId._(this.value);
}


class FirebaseStringValue extends ValueObject<String?> {
  @override
  final Either<ValueFailure<String?>, String?> value;

  factory FirebaseStringValue(String? input) {
    return FirebaseStringValue._(
      validateFirebaseStringValue(input),
    );
  }

  const FirebaseStringValue._(this.value);
}
