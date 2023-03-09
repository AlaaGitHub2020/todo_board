import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_board/application/tasks/create_new_task_form/create_new_task_form_bloc.dart';
import 'package:todo_board/domain/core/utilities/colors.dart';
import 'package:todo_board/generated/l10n.dart';

import '../../../../main.dart';

class CancelBtn extends StatelessWidget {
  const CancelBtn({Key? key}) : super(key: key);

  onPressedCancelBtn(BuildContext context, CreateNewTaskFormState state) {
    log.i("onPressedCancelBtn Started");
    context.router.pop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateNewTaskFormBloc, CreateNewTaskFormState>(
      builder: (context, state) {
        return ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppColors.errorColor),
              fixedSize: MaterialStateProperty.all(
                  Size.fromWidth(MediaQuery.of(context).size.width * 0.30))),
          onPressed: () => onPressedCancelBtn(context, state),
          child: Text(S.of(context).cancel),
        );
      },
    );
  }
}
