import 'package:dartz/dartz.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo_board/domain/messaging/messaging_failure.dart';
import 'package:todo_board/domain/messaging/user_fcm_token.dart';

abstract class IMessagingRepository {
  late UserFCMToken userFCMToken;

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future<Either<MessagingFailure, Unit>> requestPermissions();

  Future<Either<MessagingFailure, Unit>> getFCMToken();

  Future<Either<MessagingFailure, Unit>> saveFCMToken(UserFCMToken token);

  Future<Either<MessagingFailure, Unit>> initInformationDetails();

  Future<Either<MessagingFailure, Unit>>
      sendNotificationToSpecificUserDeviceUsingFCMToken(
          {String? userId,
          String? fcmTokenID,
          required UserFCMToken fcmToken,
          required String notificationTitle,
          String? notificationBody});

  Future<Either<MessagingFailure, Unit>> sendPushMessage(
      UserFCMToken token, String title, String body);
}
