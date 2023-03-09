import 'package:dartz/dartz.dart';
import 'package:todo_board/domain/auth/auth_failure.dart';
import 'package:todo_board/domain/user_profile/user_profile.dart';

abstract class IUserProfileRepository {
  Future<Either<AuthFailure, UserProfile>> getUpdatedUser();

  Future<Either<AuthFailure, Unit>> createUserProfile(
      UserProfile userProfile, String userEmail);

  Future<Either<AuthFailure, Unit>> updateUserProfile(
      UserProfile? userProfile, String userEmail);

  Future<Either<AuthFailure, Unit>> deleteUserProfile();
}
