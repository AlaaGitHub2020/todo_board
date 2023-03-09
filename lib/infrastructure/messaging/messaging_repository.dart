import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_board/domain/analytics/i_analytics_repository.dart';
import 'package:todo_board/domain/core/utilities/logger/simple_log_printer.dart';
import 'package:todo_board/domain/core/utilities/strings.dart';
import 'package:todo_board/domain/core/value_objects.dart';
import 'package:todo_board/domain/messaging/i_messaging_repository.dart';
import 'package:todo_board/domain/messaging/messaging_failure.dart';
import 'package:todo_board/domain/messaging/user_fcm_token.dart';
import 'package:todo_board/infrastructure/core/firestore_helpers.dart';
import 'package:todo_board/infrastructure/messaging/user_fcm_token_data_transfer_object.dart';
import 'package:todo_board/injection.dart';
import 'package:todo_board/presentation/routes/router.gr.dart';
import 'package:http/http.dart' as http;

@LazySingleton(as: IMessagingRepository)
class MessagingRepository implements IMessagingRepository {
  final IAnalyticsRepository _analytics;
  final FirebaseMessaging _firebaseMessaging;
  final FirebaseFirestore _firebaseFireStore;

  final log = getLogger();

  MessagingRepository(
      this._analytics, this._firebaseMessaging, this._firebaseFireStore);

  @override
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  UserFCMToken userFCMToken = UserFCMToken.empty();

  @override
  Future<Either<MessagingFailure, Unit>> getFCMToken() async {
    try {
      log.i("getFCMToken Started");
      await _firebaseMessaging.getToken().then((token) {
        log.i("token $token");
        userFCMToken = userFCMToken.copyWith(
          fcmToken: FirebaseStringValue(token),
          updatedAt: FirebaseStringValue(DateTime.now().toString()),
        );
        saveFCMToken(userFCMToken);
      });
      await _analytics.logGetFCMToken(
          fcmToken: userFCMToken.fcmToken?.getOrCrash() ?? "");
      return right(unit);
    } catch (e) {
      log.e("ERROR:$e");
      await _analytics.logErrorHappened(errorDescription: e.toString());
      return left(const MessagingFailure.unexpected());
    }
  }

  @override
  Future<Either<MessagingFailure, Unit>> initInformationDetails() async {
    try {
      log.i("initInformationDetails Started");
      var androidInitialize =
          const AndroidInitializationSettings(Strings.icAndroidLogo);
      var iosInitialize = const IOSInitializationSettings();

      var initializationSettings = InitializationSettings(
          android: androidInitialize, iOS: iosInitialize);

      await flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: onSelectNotification);

      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        log.i("------------------------OnMessage------------------");
        log.i(
            "OnMessage:${message.notification!.title}/${message.notification?.body}");

        BigTextStyleInformation bigTextStyleInformation =
            BigTextStyleInformation(
          message.notification!.body.toString(),
          htmlFormatBigText: true,
          contentTitle: message.notification!.title.toString(),
          htmlFormatContentTitle: true,
        );
        AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails(
          Strings.cChannelId,
          Strings.cChannelName,
          importance: Importance.high,
          styleInformation: bigTextStyleInformation,
          priority: Priority.high,
          playSound: true,
        );

        NotificationDetails platformChannelSpecifics = NotificationDetails(
            android: androidPlatformChannelSpecifics,
            iOS: const IOSNotificationDetails());
        await flutterLocalNotificationsPlugin.show(
          0,
          message.notification?.title,
          message.notification?.body,
          platformChannelSpecifics,
          payload: message.data[Strings.cMessageBody],
        );
      });
      await _analytics.logInitInformationDetailsForFirebaseMessaging();
      return right(unit);
    } catch (e) {
      log.e("ERROR:$e");
      await _analytics.logErrorHappened(errorDescription: e.toString());
      return left(const MessagingFailure.unexpected());
    }
  }

  @override
  Future<Either<MessagingFailure, Unit>>
      sendNotificationToSpecificUserDeviceUsingFCMToken(
          {String? userId,
          String? fcmTokenID,
          required UserFCMToken fcmToken,
          required String notificationTitle,
          String? notificationBody}) async {
    try {
      log.i("initInformationDetails Started");

      ///Not tested yet!! // todo : need  to check it carefully
      if (fcmTokenID != '' && userId != null) {
        // final userDoc = await _firebaseFireStore.userDocument();
        final userTokenDoc =
            await _firebaseFireStore.usersFCMTokensDocument(userId);
        // final userFCMToken = UserFCMTokenDto.fromDomain(fcmToken);
        // DocumentSnapshot snapshot =
        //     await userTokenDoc.userFCMTokensCollection.doc(userFCMToken.id).get();
        DocumentSnapshot snapshot = await userTokenDoc.get();
        // DocumentSnapshot snapshot = await _firebaseFireStore
        //     .collection('userTokens')
        //     .doc(fcmTokenID)
        //     .get();
        UserFCMToken theUserFCMTokenUpdatedFromFirebase =
            UserFCMTokenDto.fromFireStore(snapshot).toDomain();
        // String token = snapshot['token'];
        String token =
            theUserFCMTokenUpdatedFromFirebase.fcmToken?.getOrCrash() ?? "";
        log.i("token $token");

        // sendPushMessage(token, notificationTitle, notificationBody);
        sendPushMessage(theUserFCMTokenUpdatedFromFirebase, notificationTitle,
            notificationBody ?? "");
        await _analytics.logSendNotificationToSpecificUserDeviceUsingFCMToken();
        return right(unit);
      } else {
        log.e("ERROR: fcmTokenID || userId Is : empty || null || not found");
        await _analytics.logErrorHappened(
            errorDescription:
                "fcmTokenID || userId Is : empty || null || not found");
        return left(const MessagingFailure.unexpected());
      }
    } catch (e) {
      log.e("ERROR:$e");
      await _analytics.logErrorHappened(errorDescription: e.toString());
      return left(const MessagingFailure.unableToSendNotification());
    }
  }

  @override
  Future<Either<MessagingFailure, Unit>> requestPermissions() async {
    try {
      log.i("requestPermissions Started");
      NotificationSettings settings =
          await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        log.i("User granted permission");
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        log.i("User granted provisional permission");
      } else {
        log.i("User declined or has not accepted permission");
      }
      await _analytics.logRequestPermissions(
          permissionsStatus: settings.authorizationStatus.name);
      return right(unit);
    } catch (e) {
      log.e("ERROR:$e");
      await _analytics.logErrorHappened(errorDescription: e.toString());
      return left(const MessagingFailure.unexpected());
    }
  }

  @override
  Future<Either<MessagingFailure, Unit>> sendPushMessage(
      UserFCMToken token, String title, String body) async {
    try {
      log.i("sendPushMessage Started");
      await http.post(
        Uri.parse(Strings.cFirebaseServerApiEndPoint),
        headers: <String, String>{
          Strings.cApiContentType: Strings.cApiApplicationJson,
          Strings.cApiAuthorization: "${Strings.cApiKey}${Strings.cServerID}"
        },
        body: jsonEncode(
          <String, dynamic>{
            Strings.cApiPriority: Strings.cApiHigh,
            Strings.cApiData: <String, dynamic>{
              Strings.cApiClickAction: Strings.cApiFlutterNotificationClick,
              Strings.cApiStatus: Strings.cApiDone,
              Strings.cApiBody: body,
              Strings.cApiTitle: title,
            },
            Strings.cApiNotification: <String, dynamic>{
              Strings.cApiTitle: title,
              Strings.cApiBody: body,
              Strings.cApiAndroidChannelId: Strings.cChannelId
            },
            Strings.cApiTo: token.fcmToken?.getOrCrash(),
          },
        ),
      );

      await _analytics.logSendPushMessage();

      return right(unit);
    } catch (e) {
      log.e("ERROR:$e");
      await _analytics.logErrorHappened(errorDescription: e.toString());
      return left(const MessagingFailure.unableToSendMessage());
    }
  }

  @override
  Future<Either<MessagingFailure, Unit>> saveFCMToken(
      UserFCMToken fcmToken) async {
    try {
      log.i("saveFCMToken Started fcmToken:$fcmToken");

      ///first save it in the user document
      final userDoc = await _firebaseFireStore.userDocument();
      final userFCMToken = UserFCMTokenDto.fromDomain(fcmToken);
      await userDoc.userFCMTokensCollection
          .doc(userFCMToken.id)
          .set(userFCMToken.toJson());
      final userFCMTokenDto = UserFCMTokenDto.fromDomain(fcmToken);

      ///

      ///second save it in the userToken document for public use (if you need to send notification for another user )
      ///
      Object? cUserId = await SharedPreferences.getInstance().then(
        (value) async {
          Object? cUserId = value.get(Strings.cUserIdForSharePreferences);
          if ((cUserId != null) && (cUserId != "")) {
            return cUserId.toString();
          }
          return null;
        },
      );

      final userTokensDoc =
          await _firebaseFireStore.usersFCMTokensDocument(cUserId.toString());
      await userTokensDoc.set(userFCMTokenDto.toJson());

      ///

      await _analytics.logSaveFCMToken(
        fcmToken: fcmToken.fcmToken?.getOrCrash(),
        createdAt: fcmToken.createdAt?.getOrCrash(),
        updatedAt: fcmToken.updatedAt?.getOrCrash(),
      );

      return right(unit);
    } catch (e) {
      log.e("ERROR:$e");
      await _analytics.logErrorHappened(errorDescription: e.toString());
      return left(const MessagingFailure.unexpected());
    }
  }

  onSelectNotification(String? payload) async {
    try {
      log.i("onSelectNotification Started");
      if (payload != null && payload.isNotEmpty) {
        getIt<AppRouter>().pushNamed(payload.toString());
      } else {
        await _analytics.logErrorHappened(
            errorDescription:
                Strings.cNotAbleToNavigateToTheScreenFromTheNotification);
      }
    } catch (e) {
      log.e("ERROR:$e");
      await _analytics.logErrorHappened(errorDescription: e.toString());
      return;
    }
  }
}
