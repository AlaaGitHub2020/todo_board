import 'package:flutter/material.dart';
import 'package:todo_board/injection.dart';
import 'package:todo_board/presentation/auth/splash/widgets/splash_body.dart';
import 'package:todo_board/presentation/core/loading.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getIt.allReady(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return const SplashBody();
        } else {
          return const Loading(fullScreen: true);
        }
      },
    );
  }
}
