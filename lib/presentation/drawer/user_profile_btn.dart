import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:todo_board/generated/l10n.dart';
import 'package:todo_board/presentation/routes/router.gr.dart';

import '../../../main.dart';

class UserProfileBtn extends StatelessWidget {
  const UserProfileBtn({Key? key}) : super(key: key);

  onTapUserProfileBtn(BuildContext context) {
    log.i("onTapUserProfileBtn Started");
    context.router.push(const UserProfileRoute());
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      onTap: () => onTapUserProfileBtn(context),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20,bottom: 20,left: 10,right: 10),
            child: Text(
              S.of(context).userProfile,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
