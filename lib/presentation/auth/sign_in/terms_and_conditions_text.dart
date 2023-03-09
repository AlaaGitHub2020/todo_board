import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_board/generated/l10n.dart';

class TermsAndConditionsText extends StatelessWidget {
  final AuthAction action;

  const TermsAndConditionsText({Key? key, required this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text(
          action == AuthAction.signIn
              ? S.of(context).bySigningInYouAgreeToOurTermsAndConditions
              : S.of(context).byRegisteringYouAgreeToOurTermsAndConditions,
          style: Theme.of(context).textTheme.displayMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
