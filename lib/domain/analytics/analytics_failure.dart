import 'package:freezed_annotation/freezed_annotation.dart';

part 'analytics_failure.freezed.dart';

@freezed
class AnalyticsFailure with _$AnalyticsFailure {
  const factory AnalyticsFailure.serverError() = ServerError;

  const factory AnalyticsFailure.setUserPropertiesFailure() =
      SetUserPropertiesFailure;

  const factory AnalyticsFailure.unexpected() = Unexpected;
}
