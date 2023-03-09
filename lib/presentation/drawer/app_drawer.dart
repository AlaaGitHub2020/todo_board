import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_board/application/user_profile/user_profile_watcher/user_profile_watcher_bloc.dart';
import 'package:todo_board/injection.dart';
import 'package:todo_board/presentation/drawer/completed_task_history_btn.dart';
import 'package:todo_board/presentation/drawer/copy_rights_text.dart';
import 'package:todo_board/presentation/drawer/dark_mode_switcher.dart';
import 'package:todo_board/presentation/drawer/selectApp_language_btn.dart';
import 'package:todo_board/presentation/drawer/sign_out_btn.dart';
import 'package:todo_board/presentation/drawer/user_profile_btn.dart';
import 'package:todo_board/presentation/drawer/welcome_user_row.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserProfileWatcherBloc>(
          create: (context) => getIt<UserProfileWatcherBloc>()
            ..add(const UserProfileWatcherEvent.watchUserProfileStarted()),
        ),
      ],
      child: Drawer(
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  const WelcomeUserRow(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  const DarkModeSwitcher(),
                  buildSizedBox(),
                  const UserProfileBtn(),
                  buildSizedBox(),
                  const SelectAppLanguageBtn(),
                  buildSizedBox(),
                  const CompletedTaskHistoryBtn(),
                  buildSizedBox(),
                  const SignOutBtn(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  const CopyRightsText(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Spacer buildSpacer() => const Spacer();

  SizedBox buildSizedBox() => const SizedBox(height: 10);
}
