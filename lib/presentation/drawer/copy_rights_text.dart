import 'package:flutter/material.dart';
import 'package:todo_board/domain/core/utilities/colors.dart';
import 'package:todo_board/domain/core/utilities/strings.dart';

class CopyRightsText extends StatelessWidget {
  const CopyRightsText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        Strings.cCopyRights,
        style: Theme.of(context)
            .textTheme
            .labelSmall!
            .copyWith(color: AppColors.blackColor1),
        textAlign: TextAlign.center,
      ),
    );
  }
}
