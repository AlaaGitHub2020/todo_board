import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_board/domain/auth/user.dart' as auth_user;
import 'package:todo_board/domain/auth/value_objects.dart';
import 'package:todo_board/domain/core/value_objects.dart' as core;
import 'package:todo_board/domain/user_profile/value_objects.dart';

@lazySingleton
class FirebaseUserMapper {
  auth_user.User? toDomain(User? firebaseUser) {
    return (firebaseUser == null)
        ? null
        : auth_user.User(
            id: core.UniqueId.fromUniqueString(firebaseUser.uid),
            userName: UserName(firebaseUser.displayName ??
                firebaseUser.email!.split('@').first),
            emailAddress: EmailAddress(firebaseUser.email!),
          );
  }
}
