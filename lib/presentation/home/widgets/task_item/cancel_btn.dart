import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:todo_board/domain/core/utilities/colors.dart';
import 'package:todo_board/generated/l10n.dart';

import '../../../../main.dart';

class CancelBtn extends StatelessWidget {
  const CancelBtn({Key? key}) : super(key: key);

  onPressedCancelBtn(BuildContext context) {
    log.i("onPressedCancelBtn Started");
    context.router.pop();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.errorColor),
        ),
        onPressed: () => onPressedCancelBtn(context),
        child: Text(S.of(context).cancel));
  }
}
