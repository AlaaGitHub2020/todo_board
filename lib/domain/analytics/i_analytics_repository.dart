import 'package:dartz/dartz.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:todo_board/domain/analytics/analytics_failure.dart';

abstract class IAnalyticsRepository {
  FirebaseAnalyticsObserver getAnalyticsObserver();

  Future<Either<AnalyticsFailure, Unit>> setUserProperties(
      {String? userId, String? userRole});

  Future<Either<AnalyticsFailure, Unit>> logSingUpWithEmailAndPassword();

  Future<Either<AnalyticsFailure, Unit>> logSignInWithEmailAndPassword();

  Future<Either<AnalyticsFailure, Unit>> logAppOpen();

  Future<Either<AnalyticsFailure, Unit>> logSignOut({String? userId});

  Future<Either<AnalyticsFailure, Unit>> logResetPassword({String? userEmail});

  Future<Either<AnalyticsFailure, Unit>> logGetUpdatedUser({String? userId});

  Future<Either<AnalyticsFailure, Unit>> logCreateUser({String? userId});

  Future<Either<AnalyticsFailure, Unit>> logUpdateUser({String? userId});

  Future<Either<AnalyticsFailure, Unit>> logDeleteUser({String? userId});

  Future<Either<AnalyticsFailure, Unit>> logErrorHappened(
      {String? errorDescription});

  Future<Either<AnalyticsFailure, Unit>> logDeleteUserTask({String? taskId});

  Future<Either<AnalyticsFailure, Unit>> logCreateNewUserTask(
      {String? userId, String? taskId});

  Future<Either<AnalyticsFailure, Unit>> logUpdateUserTask({String? taskId});

  Future<Either<AnalyticsFailure, Unit>> logWatchAllUserTasks();

  Future<Either<AnalyticsFailure, Unit>> logWatchUserTasksTimerHistory();

  Future<Either<AnalyticsFailure, Unit>> logStartTaskTimer({String? taskId});

  Future<Either<AnalyticsFailure, Unit>> logStopTaskTimer({String? taskId});

  Future<Either<AnalyticsFailure, Unit>> logCreateUserTaskTimerHistory(
      {String? userId, String? taskId, String? timerHistoryId});

  Future<Either<AnalyticsFailure, Unit>> logGetFCMToken({String? fcmToken});

  Future<Either<AnalyticsFailure, Unit>> logRequestPermissions(
      {String? permissionsStatus});

  Future<Either<AnalyticsFailure, Unit>> logSaveFCMToken(
      {String? fcmToken, String? createdAt, String? updatedAt});

  Future<Either<AnalyticsFailure, Unit>>
      logInitInformationDetailsForFirebaseMessaging();

  Future<Either<AnalyticsFailure, Unit>>
      logSendNotificationToSpecificUserDeviceUsingFCMToken();

  Future<Either<AnalyticsFailure, Unit>> logSendPushMessage();
}
