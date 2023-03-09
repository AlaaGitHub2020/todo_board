import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_board/domain/auth/user.dart' as my_user;
import 'package:todo_board/domain/auth/value_objects.dart';

import 'auth_failure.dart';

abstract class IAuthRepository {
  late ActionCodeSettings actionCodeSettings;

  Future<Option<my_user.User>> getSignedInUser();

  Future<Either<AuthFailure, Unit>> singUpWithEmailAndPassword();

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required String userID,
  });

  Future<Either<AuthFailure, Unit>> signOut();

  Future<Either<AuthFailure, Unit>> resetPassword({
    required EmailAddress emailAddress,
  });
}
