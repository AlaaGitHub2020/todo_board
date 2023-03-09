import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failure.freezed.dart';

@freezed
class AuthFailure with _$AuthFailure {
  const factory AuthFailure.serverError() = ServerError;

  const factory AuthFailure.emailAlreadyInUse() = EmailAlreadyInUse;

  const factory AuthFailure.invalidEmailORPassword() = InvalidEmailORPassword;

  const factory AuthFailure.invalidEmail() = InvalidEmail;

  const factory AuthFailure.requiredData() = RequiredData;

  const factory AuthFailure.userProfileDataError() = UserProfileDataError;
}
