import 'package:auto_route/auto_route.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_board/domain/auth/i_auth_repository.dart';
import 'package:todo_board/domain/auth/value_objects.dart';
import 'package:todo_board/domain/core/utilities/strings.dart';
import 'package:todo_board/domain/user_profile/i_user_profile_repository.dart';
import 'package:todo_board/domain/user_profile/user_profile.dart';
import 'package:todo_board/domain/user_profile/value_objects.dart';
import 'package:todo_board/injection.dart';
import 'package:todo_board/presentation/auth/sign_in/terms_and_conditions_text.dart';
import 'package:todo_board/presentation/auth/sign_in/welcome_to_todo_board_text.dart';
import 'package:todo_board/presentation/core/widgets/responcive_header.dart';
import 'package:todo_board/presentation/core/widgets/responcive_side_image_icon.dart';
import 'package:todo_board/presentation/routes/router.gr.dart';

import '../../../main.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      actions: [
        buildForgotPasswordAction(),
        buildAuthStateSignedIn(),
        buildAuthStateUserCreated(),
      ],
      styles: {
        EmailFormStyle(
          signInButtonVariant: ButtonVariant.filled,
          inputDecorationTheme: Theme.of(context).inputDecorationTheme,
        ),
      },
      headerBuilder: headerImage(Strings.icLogo),
      sideBuilder: sideImage(Strings.icLogo),
      subtitleBuilder: (context, action) {
        return WelcomeToToDoBoardText(action: action);
      },
      footerBuilder: (context, AuthAction action) {
        return TermsAndConditionsText(action: action);
      },
    );
  }

  AuthStateChangeAction<UserCreated> buildAuthStateUserCreated() {
    return AuthStateChangeAction<UserCreated>(
      (context, state) async {
        if (!state.credential.user!.emailVerified) {
          log.i(
              "User Registered with new email So he Need To Verify it to let him in ");
          context.router.push(EmailVerificationRoute(
              email: state.credential.user?.email ?? ''));
        } else {
          log.i("getIt<UserProfileRepository>()");
          await getIt<IUserProfileRepository>()
              .createUserProfile(
                  UserProfile(
                    emailAddress:
                        EmailAddress(state.credential.user?.email ?? ""),
                    userName: UserName(state.credential.user?.displayName ??
                        state.credential.additionalUserInfo?.username ??
                        ''),
                  ),
                  state.credential.user?.email ?? "")
              .whenComplete(() async {
            log.i("Move to HomeRoute");
            await getIt<IAuthRepository>()
                .singUpWithEmailAndPassword()
                .whenComplete(() {
              context.router.replace(const HomeRoute());
            });
          });
        }
      },
    );
  }

  ForgotPasswordAction buildForgotPasswordAction() {
    return ForgotPasswordAction(
      (context, email) async {
        log.i("move to ForgotPasswordRoute");
        await getIt<IAuthRepository>()
            .resetPassword(emailAddress: EmailAddress(email.toString()))
            .whenComplete(() {
          context.router.push(ForgotPasswordRoute(email: email));
        });
      },
    );
  }

  AuthStateChangeAction<SignedIn> buildAuthStateSignedIn() {
    return AuthStateChangeAction<SignedIn>(
      (context, state) async {
        if (!state.user!.emailVerified) {
          log.i(
              "User trying to Sign in with UnVerified email so He Need to Verify it first ");
          context.router
              .push(EmailVerificationRoute(email: state.user?.email ?? ""));
        } else {
          log.i(
              "Email Verified and user going to SignIn So Create or Update the user Profile ");
          getIt<IAuthRepository>()
              .signInWithEmailAndPassword(userID: state.user!.uid);

          await getIt<IUserProfileRepository>()
              .createUserProfile(
                  UserProfile(
                    emailAddress: EmailAddress(state.user?.email ?? ""),
                    userName: UserName(state.user?.displayName ??
                        state.user?.email
                            ?.substring(0, state.user?.email!.indexOf("@")) ??
                        ''),
                  ),
                  state.user?.email ?? "")
              .whenComplete(() {
            log.i(
                "UserProfile Created and user Signed in Correctly so Move to your Home");
            context.router.replace(const HomeRoute());
          });
        }
      },
    );
  }
}
