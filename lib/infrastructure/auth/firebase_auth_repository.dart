import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_board/domain/analytics/i_analytics_repository.dart';
import 'package:todo_board/domain/auth/auth_failure.dart';
import 'package:todo_board/domain/auth/i_auth_repository.dart';
import 'package:todo_board/domain/auth/user.dart' as auth_user;
import 'package:todo_board/domain/auth/value_objects.dart';
import 'package:todo_board/domain/core/utilities/logger/simple_log_printer.dart';
import 'package:todo_board/domain/core/utilities/strings.dart';
import 'package:todo_board/infrastructure/auth/firebase_user_mapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// if I didn't used the Auth Firebase UI I should build the Auth functionality here!!

@LazySingleton(as: IAuthRepository)
class FirebaseAuthRepository implements IAuthRepository {
  late final FirebaseAuth _firebaseAuth;

  final FirebaseUserMapper _firebaseUserMapper;
  final IAnalyticsRepository _analytics;
  final log = getLogger();

  FirebaseAuthRepository(
    this._firebaseAuth,
    this._firebaseUserMapper,
    this._analytics,
  );

  @override
  Future<Either<AuthFailure, Unit>> singUpWithEmailAndPassword() async {
    try {
      log.i("createUserWithEmailAndPassword with firebase done !!");
      await _analytics.logSingUpWithEmailAndPassword();
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        log.e(e);
        await _analytics.logErrorHappened(errorDescription: e.toString());
        return left(const AuthFailure.emailAlreadyInUse());
      } else {
        log.e(e);
        await _analytics.logErrorHappened(errorDescription: e.toString());
        return left(const AuthFailure.serverError());
      }
    } catch (e) {
      log.e(e);
      await _analytics.logErrorHappened(errorDescription: e.toString());
      return left(const AuthFailure.requiredData());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required String userID,
  }) async {
    try {
      log.i("signInWithEmailAndPassword with firebase done !!");
      await SharedPreferences.getInstance().then((value) {
        value.setString(Strings.cUserIdForSharePreferences, userID);
      });
      await _analytics.logSignInWithEmailAndPassword();
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == "wrong-password" || e.code == "user-not-found") {
        log.e(e);
        await _analytics.logErrorHappened(errorDescription: e.toString());
        return left(const AuthFailure.invalidEmailORPassword());
      } else {
        log.e(e);
        await _analytics.logErrorHappened(errorDescription: e.toString());
        return left(const AuthFailure.serverError());
      }
    } catch (e) {
      log.e(e);
      await _analytics.logErrorHappened(errorDescription: e.toString());
      return left(const AuthFailure.requiredData());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signOut() async {
    try {
      Future.wait([
        _firebaseAuth.signOut(),
        SharedPreferences.getInstance().then(
          (value) async {
            Object? cUserId = value.get(Strings.cUserIdForSharePreferences);
            if ((cUserId != null) && (cUserId != "")) {
              await _analytics.logSignOut(userId: cUserId.toString());
            }
          },
        ),
      ]);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      log.e(e);
      await _analytics.logErrorHappened(errorDescription: e.toString());
      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<Option<auth_user.User>> getSignedInUser() async {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      return optionOf(
        _firebaseUserMapper.toDomain(firebaseUser),
      );
    }
    return none();
  }

  @override
  Future<Either<AuthFailure, Unit>> resetPassword({
    required EmailAddress emailAddress,
  }) async {
    try {
      final String emailAddressString = emailAddress.getOrCrash()!;
      log.i("resetPassword code with firebase done sent to the user email !!");
      await _analytics.logResetPassword(userEmail: emailAddressString);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email" || e.code == "user-not-found") {
        log.e(e);
        await _analytics.logErrorHappened(errorDescription: e.toString());
        return left(const AuthFailure.invalidEmail());
      } else {
        log.e(e);
        await _analytics.logErrorHappened(errorDescription: e.toString());
        return left(const AuthFailure.serverError());
      }
    } catch (e) {
      log.e(e);
      await _analytics.logErrorHappened(errorDescription: e.toString());
      return left(const AuthFailure.requiredData());
    }
  }

  @override
  ActionCodeSettings actionCodeSettings = ActionCodeSettings(
    url: Strings.cFirebaseHostingUrl,
    handleCodeInApp: true,
    androidMinimumVersion: Strings.cAndroidMinimumVersion,
    androidPackageName: Strings.cAndroidPackageName,
    iOSBundleId: Strings.cIOSBundleId,
  );
}
