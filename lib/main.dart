import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide PhoneAuthProvider, EmailAuthProvider;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_board/domain/analytics/i_analytics_repository.dart';
import 'package:todo_board/domain/auth/auth_failure.dart';
import 'package:todo_board/domain/core/utilities/logger/simple_log_printer.dart';
import 'package:todo_board/domain/core/utilities/strings.dart';
import 'package:todo_board/domain/user_profile/i_user_profile_repository.dart';
import 'package:todo_board/domain/user_profile/user_profile.dart';
import 'package:todo_board/firebase_options.dart';
import 'package:todo_board/injection.dart';
import 'package:todo_board/presentation/core/app_widget.dart';

final log = getLogger();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log.i("Handling a background message: ${message.messageId}");
  log.i("Handling a background message: $message");
}

void main() async {
  log.i("main Started");
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await appConfiguration();
  runApp(const AppWidget());
  FlutterNativeSplash.remove();
}

Future<void> appConfiguration() async {
  try {
    log.i("appConfiguration Started");
    if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
      WidgetsFlutterBinding.ensureInitialized();
      addFontLicense();
      prepareTheLogger();
      await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp]);
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
      await configureInjection(Environment.prod);
      await setupPackageInfoService();
      await getIt<FirebaseMessaging>().getInitialMessage();
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
      FirebaseUIAuth.configureProviders([EmailAuthProvider()]);
      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;
      await FirebaseAppCheck.instance.activate(
        webRecaptchaSiteKey: 'myReCAPTCHA_key',
        androidProvider: AndroidProvider.debug,
      );

      await SharedPreferences.getInstance().then(
        (value) async {
          Object? cUserId = value.get(Strings.cUserIdForSharePreferences);
          if ((cUserId != null) && (cUserId != "")) {
            Either<AuthFailure, UserProfile> userProfileOrFailure =
                await getIt<IUserProfileRepository>().getUpdatedUser();
            userProfileOrFailure.fold(
              (failure) {
                log.e("failure:$failure");
              },
              (updatedUser) {
                log.i("updatedUser:$updatedUser");
                getIt<IUserProfileRepository>().updateUserProfile(
                    updatedUser, updatedUser.emailAddress.getOrCrash()!);
                getIt<IAnalyticsRepository>().setUserProperties(
                    userId: updatedUser.emailAddress.getOrCrash()!,
                    userRole: Strings.cNormalUser);
              },
            );
          }
        },
      );
      await getIt<IAnalyticsRepository>().logAppOpen();
    } else if (Platform.isWindows) {
      // todo : build the Windows App version
    } else {
      // todo : build the other platform App version or ignore them
    }
  } catch (e) {
    log.e("ERRROR:$e");
  }
}

void addFontLicense() {
  try {
    log.i("addFontLicense Started");
    LicenseRegistry.addLicense(() async* {
      final license = await rootBundle.loadString('google_fonts/OFL.txt');
      yield LicenseEntryWithLineBreaks(['google_fonts'], license);
    });
  } catch (e) {
    log.e(e);
  }
}

void prepareTheLogger() {
  try {
    log.i("prepareTheLogger Started");
    if (kReleaseMode) {
      Logger.level = Level.info;
    } else {
      Logger.level = Level.debug;
    }
  } catch (e) {
    log.e(e);
  }
}
