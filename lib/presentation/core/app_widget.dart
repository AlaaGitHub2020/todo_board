import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_board/application/auth/auth_bloc.dart';
import 'package:todo_board/application/core/language/application_language_cubit.dart';
import 'package:todo_board/application/core/language/language_cubit.dart';
import 'package:todo_board/application/core/theme/theme_cubit.dart';
import 'package:todo_board/domain/analytics/i_analytics_repository.dart';
import 'package:todo_board/domain/core/utilities/colors.dart';
import 'package:todo_board/domain/core/utilities/strings.dart';
import 'package:todo_board/domain/messaging/i_messaging_repository.dart';
import 'package:todo_board/generated/l10n.dart';
import 'package:todo_board/injection.dart';
import 'package:todo_board/presentation/routes/router.gr.dart';
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';

import '../../main.dart';

class LabelOverrides extends DefaultLocalizations {
  const LabelOverrides();

  @override
  String get emailInputLabel => 'Enter your email';
}

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider<ApplicationLanguageCubit>(
          create: (context) => ApplicationLanguageCubit(),
        ),
        BlocProvider<LanguageCubit>(
          create: (context) => LanguageCubit(),
        ),
        BlocProvider<AuthBloc>(
          create: (BuildContext context) =>
              getIt<AuthBloc>()..add(const AuthEvent.authCheckRequested()),
        ),
      ],
      child: const ToDoBoard(),
    );
  }
}

class ToDoBoard extends StatefulWidget {
  const ToDoBoard({Key? key}) : super(key: key);

  @override
  State<ToDoBoard> createState() => _ToDoBoardState();
}

class _ToDoBoardState extends State<ToDoBoard> {
  final heroController = HeroController();
  final _appRouter = AppRouter();

  checkApplicationSettings() async {
    await SharedPreferences.getInstance().then((value) {
      bool? darkActive = value.getBool(Strings.cApplicationDarkMode);
      if (darkActive != null && darkActive) {
        context.read<ThemeCubit>().setDarkMode();
      }
      if (darkActive == null) {
        log.i(
            "DarkMode is not set yet so that we use the device mode after changing the dark mode from settings it will follow the user preference");
        var brightness =
            SchedulerBinding.instance.platformDispatcher.platformBrightness;
        bool isDarkMode = brightness == Brightness.dark;
        log.i("deviceDarkMode active: $isDarkMode");
        if (isDarkMode) {
          context.read<ThemeCubit>().setDarkMode();
        }
      }

      String? applicationLanguage =
          value.getString(Strings.cApplicationLanguage);
      if (applicationLanguage != null) {
        context
            .read<LanguageCubit>()
            .updateLanguage(language: applicationLanguage);
        context
            .read<ApplicationLanguageCubit>()
            .updateApplicationLanguage(applicationLanguage);
      }
      if (applicationLanguage == null) {
        String applicationLanguage = context
            .read<ApplicationLanguageCubit>()
            .selectDefaultApplicationLanguageDependOnDeviceLanguage();
        context
            .read<LanguageCubit>()
            .updateLanguage(language: applicationLanguage);

        context
            .read<ApplicationLanguageCubit>()
            .updateApplicationLanguage(applicationLanguage);
      }
    });
  }

  @override
  void initState() {
    checkApplicationSettings();
    getIt<IMessagingRepository>().requestPermissions();
    getIt<IMessagingRepository>().getFCMToken();
    getIt<IMessagingRepository>().initInformationDetails();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: Theme.of(context).brightness,
        statusBarIconBrightness: Theme.of(context).brightness,
        statusBarColor: AppColors.primaryColor,
        systemNavigationBarColor: AppColors.primaryColor,
      ),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: context.watch<ApplicationLanguageCubit>().state,
      title: Strings.appTitle,
      theme: context.watch<ThemeCubit>().state.theme,
      routerDelegate: _appRouter.delegate(
          navigatorObservers: () => (!kIsWeb)
              ? [getIt<IAnalyticsRepository>().getAnalyticsObserver()]
              : [
                  // todo : need to support the Analytics for web
                ]),
      routeInformationParser: _appRouter.defaultRouteParser(),
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: [
        S.delegate,
        FirebaseUILocalizations.withDefaultOverrides(const LabelOverrides()),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FirebaseUILocalizations.delegate,
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        for (var locale in supportedLocales) {
          if (locale.languageCode == deviceLocale!.languageCode &&
              locale.countryCode == deviceLocale.countryCode) {
            return locale;
          }
        }
        return null;
      },
    );
  }
}
