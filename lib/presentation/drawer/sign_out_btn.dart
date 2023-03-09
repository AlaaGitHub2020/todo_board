import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_board/application/auth/auth_bloc.dart';
import 'package:todo_board/domain/core/utilities/colors.dart';
import 'package:todo_board/generated/l10n.dart';
import 'package:todo_board/presentation/routes/router.gr.dart';

import '../../../main.dart';

class SignOutBtn extends StatelessWidget {
  const SignOutBtn({Key? key}) : super(key: key);

  onTapSignOutBtn(BuildContext context) async {
    log.i("onTapSignOutBtn Started");
    context.read<AuthBloc>().add(const AuthEvent.signedOut());
    context.router.replace(const SplashRoute());
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      onTap: () => onTapSignOutBtn(context),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).signOut,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Icon(
              Icons.exit_to_app_rounded,
              color: AppColors.errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
