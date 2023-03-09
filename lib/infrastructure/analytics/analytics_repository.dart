import 'package:dartz/dartz.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_board/domain/analytics/analytics_failure.dart';
import 'package:todo_board/domain/analytics/i_analytics_repository.dart';
import 'package:todo_board/domain/core/utilities/logger/simple_log_printer.dart';
import 'package:todo_board/domain/core/utilities/strings.dart';

@LazySingleton(as: IAnalyticsRepository)
class AnalyticsRepository implements IAnalyticsRepository {
  final FirebaseAnalytics _analytics;

  final log = getLogger();

  AnalyticsRepository(this._analytics);

  @override
  FirebaseAnalyticsObserver getAnalyticsObserver() {
    return FirebaseAnalyticsObserver(analytics: _analytics);
  }

  @override
  Future<Either<AnalyticsFailure, Unit>> logCreateUser({String? userId}) async {
    try {
      await _analytics.logEvent(
        name: Strings.cCreateUser,
        parameters: {Strings.cUserID: userId},
      );
      return right(unit);
    } catch (e) {
      log.e("ERROR :$e");
      return left(const AnalyticsFailure.serverError());
    }
  }

  @override
  Future<Either<AnalyticsFailure, Unit>> logDeleteUser({String? userId}) async {
    try {
      await _analytics.logEvent(
        name: Strings.cDeleteUser,
        parameters: {Strings.cUserID: userId},
      );
      return right(unit);
    } catch (e) {
      log.e("ERROR :$e");
      return left(const AnalyticsFailure.serverError());
    }
  }

  @override
  Future<Either<AnalyticsFailure, Unit>> logErrorHappened(
      {String? errorDescription}) async {
    try {
      await _analytics.logEvent(
        name: Strings.cErrorHappened,
        parameters: {Strings.cErrorDescription: errorDescription},
      );
      return right(unit);
    } catch (e) {
      log.e("ERROR :$e");
      return left(const AnalyticsFailure.serverError());
    }
  }

  @override
  Future<Either<AnalyticsFailure, Unit>> logGetUpdatedUser(
      {String? userId}) async {
    try {
      await _analytics.logEvent(
        name: Strings.cGetUpdatedUser,
        parameters: {Strings.cUserID: userId},
      );
      return right(unit);
    } catch (e) {
      log.e("ERROR :$e");
      return left(const AnalyticsFailure.serverError());
    }
  }

  @override
  Future<Either<AnalyticsFailure, Unit>> logResetPassword(
      {String? userEmail}) async {
    try {
      await _analytics.logEvent(
        name: Strings.cResetPassword,
        parameters: {Strings.cUserEmail: userEmail},
      );
      return right(unit);
    } catch (e) {
      log.e("ERROR :$e");
      return left(const AnalyticsFailure.serverError());
    }
  }

  @override
  Future<Either<AnalyticsFailure, Unit>> logSignInWithEmailAndPassword() async {
    try {
      await _analytics.logLogin(
          loginMethod: Strings.cSignInWithEmailAndPassword);
      return right(unit);
    } catch (e) {
      log.e("ERROR :$e");
      return left(const AnalyticsFailure.unexpected());
    }
  }

  @override
  Future<Either<AnalyticsFailure, Unit>> logSignOut({String? userId}) async {
    try {
      await _analytics.logEvent(
        name: Strings.cSignOut,
        parameters: {Strings.cUserID: userId},
      );
      return right(unit);
    } catch (e) {
      log.e("ERROR :$e");
      return left(const AnalyticsFailure.serverError());
    }
  }

  @override
  Future<Either<AnalyticsFailure, Unit>> logSingUpWithEmailAndPassword() async {
    try {
      await _analytics.logSignUp(
          signUpMethod: Strings.cSingUpWithEmailAndPassword);
      return right(unit);
    } catch (e) {
      log.e("ERROR :$e");
      return left(const AnalyticsFailure.unexpected());
    }
  }

  @override
  Future<Either<AnalyticsFailure, Unit>> logUpdateUser({String? userId}) async {
    try {
      await _analytics.logEvent(
        name: Strings.cUpdateUser,
        parameters: {Strings.cUserID: userId},
      );
      return right(unit);
    } catch (e) {
      log.e("ERROR :$e");
      return left(const AnalyticsFailure.serverError());
    }
  }

  @override
  Future<Either<AnalyticsFailure, Unit>> setUserProperties(
      {String? userId, String? userRole}) async {
    try {
      await _analytics.setUserId(id: userId);
      await _analytics.setUserProperty(
          name: Strings.cUserRole, value: userRole);
      return right(unit);
    } catch (e) {
      log.e("ERROR :$e");
      return left(const AnalyticsFailure.setUserPropertiesFailure());
    }
  }

  @override
  Future<Either<AnalyticsFailure, Unit>> logAppOpen() async {
    try {
      await _analytics.logAppOpen();
      return right(unit);
    } catch (e) {
      log.e("ERROR :$e");
      return left(const AnalyticsFailure.serverError());
    }
  }

  @override
  Future<Either<AnalyticsFailure, Unit>> logDeleteUserTask(
      {String? taskId}) async {
    try {
      await _analytics.logEvent(
        name: Strings.cDeleteUserTask,
        parameters: {Strings.cTaskID: taskId},
      );
      return right(unit);
    } catch (e) {
      log.e("ERROR :$e");
      return left(const AnalyticsFailure.serverError());
    }
  }

  @override
  Future<Either<AnalyticsFailure, Unit>> logCreateNewUserTask(
      {String? userId, String? taskId}) async {
    try {
      await _analytics.logEvent(
        name: Strings.cCreateNewUserTask,
        parameters: {Strings.cUserID: userId, Strings.cTaskId: taskId},
      );
      return right(unit);
    } catch (e) {
      log.e("ERROR :$e");
      return left(const AnalyticsFailure.serverError());
    }
  }

  @override
  Future<Either<AnalyticsFailure, Unit>> logUpdateUserTask(
      {String? taskId}) async {
    try {
      await _analytics.logEvent(
        name: Strings.cUpdateUserTask,
        parameters: {Strings.cTaskId: taskId},
      );
      return right(unit);
    } catch (e) {
      log.e("ERROR :$e");
      return left(const AnalyticsFailure.serverError());
    }
  }

  @override
  Future<Either<AnalyticsFailure, Unit>> logWatchAllUserTasks() async {
    try {
      await _analytics.logEvent(name: Strings.cWatchAllUserTasks);
      return right(unit);
    } catch (e) {
      log.e("ERROR :$e");
      return left(const AnalyticsFailure.serverError());
    }
  }

  @override
  Future<Either<AnalyticsFailure, Unit>> logStartTaskTimer(
      {String? taskId}) async {
    try {
      await _analytics.logEvent(
          name: Strings.cStartTaskTimer, parameters: {Strings.cTaskId: taskId});
      return right(unit);
    } catch (e) {
      log.e("ERROR :$e");
      return left(const AnalyticsFailure.serverError());
    }
  }

  @override
  Future<Either<AnalyticsFailure, Unit>> logStopTaskTimer(
      {String? taskId}) async {
    try {
      await _analytics.logEvent(
          name: Strings.cStopTaskTimer, parameters: {Strings.cTaskId: taskId});
      return right(unit);
    } catch (e) {
      log.e("ERROR :$e");
      return left(const AnalyticsFailure.serverError());
    }
  }

  @override
  Future<Either<AnalyticsFailure, Unit>> logCreateUserTaskTimerHistory(
      {String? userId, String? taskId, String? timerHistoryId}) async {
    try {
      await _analytics.logEvent(
        name: Strings.cCreateUserTaskTimerHistory,
        parameters: {
          Strings.cUserID: userId,
          Strings.cTaskId: taskId,
          Strings.cTimerHistoryId: timerHistoryId,
        },
      );
      return right(unit);
    } catch (e) {
      log.e("ERROR :$e");
      return left(const AnalyticsFailure.serverError());
    }
  }

  @override
  Future<Either<AnalyticsFailure, Unit>> logWatchUserTasksTimerHistory() async {
    try {
      await _analytics.logEvent(name: Strings.cWatchUserTasksTimerHistory);
      return right(unit);
    } catch (e) {
      log.e("ERROR :$e");
      return left(const AnalyticsFailure.serverError());
    }
  }

  @override
  Future<Either<AnalyticsFailure, Unit>> logGetFCMToken(
      {String? fcmToken}) async {
    try {
      await _analytics.logEvent(
        name: Strings.cGetFCMToken,
        parameters: {Strings.cFCMToken: fcmToken},
      );
      return right(unit);
    } catch (e) {
      log.e("ERROR :$e");
      return left(const AnalyticsFailure.serverError());
    }
  }

  @override
  Future<Either<AnalyticsFailure, Unit>> logRequestPermissions(
      {String? permissionsStatus}) async {
    try {
      await _analytics.logEvent(
        name: Strings.cRequestPermissions,
        parameters: {Strings.cPermissionsStatus: permissionsStatus},
      );
      return right(unit);
    } catch (e) {
      log.e("ERROR :$e");
      return left(const AnalyticsFailure.serverError());
    }
  }

  @override
  Future<Either<AnalyticsFailure, Unit>> logSaveFCMToken(
      {String? fcmToken, String? createdAt, String? updatedAt}) async {
    try {
      await _analytics.logEvent(
        name: Strings.cSaveFCMToken,
        parameters: {
          Strings.cFCMToken: fcmToken,
          Strings.cCreatedAt2: createdAt,
          Strings.cUpdatedAt: updatedAt,
        },
      );
      return right(unit);
    } catch (e) {
      log.e("ERROR :$e");
      return left(const AnalyticsFailure.serverError());
    }
  }

  @override
  Future<Either<AnalyticsFailure, Unit>>
      logInitInformationDetailsForFirebaseMessaging() async {
    try {
      await _analytics.logEvent(
          name: Strings.cInitInformationDetailsForFirebaseMessaging);
      return right(unit);
    } catch (e) {
      log.e("ERROR :$e");
      return left(const AnalyticsFailure.serverError());
    }
  }

  @override
  Future<Either<AnalyticsFailure, Unit>>
      logSendNotificationToSpecificUserDeviceUsingFCMToken() async {
    try {
      await _analytics.logEvent(
          name: Strings.cSendNotificationToSpecificUserDeviceUsingFCMToken);
      return right(unit);
    } catch (e) {
      log.e("ERROR :$e");
      return left(const AnalyticsFailure.serverError());
    }
  }

  @override
  Future<Either<AnalyticsFailure, Unit>> logSendPushMessage() async {
    try {
      await _analytics.logEvent(name: Strings.cSendPushMessage);
      return right(unit);
    } catch (e) {
      log.e("ERROR :$e");
      return left(const AnalyticsFailure.serverError());
    }
  }
}
