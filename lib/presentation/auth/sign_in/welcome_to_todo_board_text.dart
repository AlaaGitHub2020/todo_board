import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_board/generated/l10n.dart';

class WelcomeToToDoBoardText extends StatelessWidget {
  final AuthAction action;

  const WelcomeToToDoBoardText(
      {Key? key, required this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        action == AuthAction.signIn
            ? S.of(context).welcomeToToDoBoardAppPleaseSignInToContinue
            : S
                .of(context)
                .welcomeToToDoBoardAppPleaseCreateAnAccountToContinue,
        style: Theme.of(context).textTheme.displayMedium,
        textAlign: TextAlign.center,
      ),
    );
  }
}
