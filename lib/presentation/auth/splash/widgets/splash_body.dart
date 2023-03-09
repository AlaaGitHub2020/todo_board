import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_board/application/auth/auth_bloc.dart';
import 'package:todo_board/domain/messaging/i_messaging_repository.dart';
import 'package:todo_board/injection.dart';
import 'package:todo_board/presentation/auth/sign_in/sign_in_page.dart';
import 'package:todo_board/presentation/core/loading.dart';
import 'package:todo_board/presentation/home/home_page.dart';

import '../../../../main.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({Key? key}) : super(key: key);

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  @override
  void initState() {
    getIt<IMessagingRepository>().requestPermissions();
    getIt<IMessagingRepository>().getFCMToken();
    getIt<IMessagingRepository>().initInformationDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (BuildContext context, authState) {
        authState.map(
          submitting: (_) {},
          initial: (_) {},
          authenticated: (_) {
            log.i("I am authenticated");
          },
          unauthenticated: (_) {
            log.i("I am unauthenticated");
          },
        );
      },
      child: buildSplashBody(),
    );
  }

  BlocBuilder<AuthBloc, AuthState> buildSplashBody() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return state.map(
          initial: (_) {
            return Container();
          },
          authenticated: (_) {
            return const HomePage();
          },
          unauthenticated: (_) {
            return const SignInPage();
          },
          submitting: (_) {
            return const Loading(fullScreen: true);
          },
        );
      },
    );
  }
}
