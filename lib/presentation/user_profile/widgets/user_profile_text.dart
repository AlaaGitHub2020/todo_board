import 'package:flutter/material.dart';
import 'package:todo_board/domain/core/utilities/colors.dart';
import 'package:todo_board/generated/l10n.dart';

class UserProfileText extends StatelessWidget {
  const UserProfileText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      S.of(context).userProfile,
      style: Theme.of(context).textTheme.displayMedium!
          .copyWith(fontSize: 18, color: AppColors.whiteColor1),
    );
  }
}
