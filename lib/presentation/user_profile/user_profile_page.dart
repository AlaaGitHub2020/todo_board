import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_board/application/user_profile/user_profile_watcher/user_profile_watcher_bloc.dart';
import 'package:todo_board/domain/core/utilities/colors.dart';
import 'package:todo_board/generated/l10n.dart';
import 'package:todo_board/injection.dart';
import 'package:todo_board/presentation/core/loading.dart';
import 'package:todo_board/presentation/user_profile/widgets/user_profile_form.dart';
import 'package:todo_board/presentation/user_profile/widgets/user_profile_text.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: buildAppBar(context),
      body: MultiBlocProvider(providers: [
        BlocProvider<UserProfileWatcherBloc>(
          create: (context) => getIt<UserProfileWatcherBloc>()
            ..add(const UserProfileWatcherEvent.watchUserProfileStarted()),
        ),
      ], child: buildUserProfileForm()),
    );
  }

  BlocBuilder buildUserProfileForm() {
    return BlocBuilder<UserProfileWatcherBloc, UserProfileWatcherState>(
      builder: (context, state) {
        return state.map(
          initial: (_) => Container(),
          loadInProgress: (_) => const Loading(),
          loadSuccess: (userProfile) =>
              UserProfileForm(userProfile: userProfile),
          loadFailure: (userFailure) => Text(
            S.of(context).errorWithFetchingYourProfile,
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(color: AppColors.errorColor),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      title: const UserProfileText(),
      centerTitle: false,
    );
  }
}
