import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_board/application/user_profile/user_profile_watcher/user_profile_watcher_bloc.dart';
import 'package:todo_board/domain/core/utilities/colors.dart';
import 'package:todo_board/generated/l10n.dart';
import 'package:todo_board/presentation/core/loading.dart';

class WelcomeUserRow extends StatelessWidget {
  const WelcomeUserRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          S.of(context).welcome,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        BlocBuilder<UserProfileWatcherBloc, UserProfileWatcherState>(
          builder: (context, state) {
            return state.map(
              initial: (_) => Container(),
              loadInProgress: (_) => const Loading(),
              loadSuccess: (userProfile) => Text(
                "${userProfile.userProfile.userName?.getOrCrash()}",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: AppColors.primaryColor),
              ),
              loadFailure: (userFailure) => Text(
                S.of(context).user,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: AppColors.primaryColor),
              ),
            );
          },
        ),
        const Icon(Icons.person),
      ],
    );
  }
}
