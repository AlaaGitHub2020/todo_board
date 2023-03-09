import 'package:auto_route/auto_route.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_board/domain/auth/i_auth_repository.dart';
import 'package:todo_board/domain/auth/value_objects.dart';
import 'package:todo_board/domain/user_profile/i_user_profile_repository.dart';
import 'package:todo_board/domain/user_profile/user_profile.dart';
import 'package:todo_board/domain/user_profile/value_objects.dart';
import 'package:todo_board/injection.dart';
import 'package:todo_board/presentation/core/widgets/responcive_header.dart';
import 'package:todo_board/presentation/core/widgets/responcive_side_image_icon.dart';
import 'package:todo_board/presentation/routes/router.gr.dart';

import '../../../main.dart';

class EmailVerificationPage extends StatelessWidget {
  final String email;

  const EmailVerificationPage({Key? key, required this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmailVerificationScreen(
      headerBuilder: headerIcon(Icons.verified),
      sideBuilder: sideIcon(Icons.verified),
      actionCodeSettings: getIt<IAuthRepository>().actionCodeSettings,
      actions: [
        buildEmailVerifiedAction(context),
        buildAuthCancelledAction(),
      ],
    );
  }

  AuthCancelledAction buildAuthCancelledAction() {
    return AuthCancelledAction((context) {
      FirebaseUIAuth.signOut(context: context);
      context.router.replace(const SignInRoute());
    });
  }

  EmailVerifiedAction buildEmailVerifiedAction(BuildContext context) {
    return EmailVerifiedAction(() async {
      log.i("EmailVerifiedAction");
      await getIt<IUserProfileRepository>()
          .createUserProfile(
              UserProfile(
                emailAddress: EmailAddress(email),
                userName: UserName(email.substring(0, email.indexOf("@"))),
              ),
              email)
          .whenComplete(() {
        log.i("UserProfile Created You Can Go in");
        context.router.replace(const HomeRoute());
      });
    });
  }
}
