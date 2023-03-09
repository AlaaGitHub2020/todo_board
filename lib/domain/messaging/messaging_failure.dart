import 'package:freezed_annotation/freezed_annotation.dart';

part 'messaging_failure.freezed.dart';

@freezed
class MessagingFailure with _$MessagingFailure {
  const factory MessagingFailure.serverError() = ServerError;

  const factory MessagingFailure.unableToSendNotification() =
      UnableToSendNotification;

  const factory MessagingFailure.unableToSendMessage() = UnableToSendMessage;

  const factory MessagingFailure.unexpected() = Unexpected;
}
