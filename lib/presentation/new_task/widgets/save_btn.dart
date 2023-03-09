import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_board/application/tasks/create_new_task_form/create_new_task_form_bloc.dart';
import 'package:todo_board/generated/l10n.dart';
import 'package:todo_board/presentation/new_task/widgets/disabled_btn.dart';

import '../../../../main.dart';

class SaveBtn extends StatelessWidget {
  const SaveBtn({Key? key}) : super(key: key);

  onPressedSaveBtn(BuildContext context) {
    log.i("onPressedSaveBtn Started");
    context
        .read<CreateNewTaskFormBloc>()
        .add(const CreateNewTaskFormEvent.savedPressed());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateNewTaskFormBloc, CreateNewTaskFormState>(
      builder: (context, createNewTaskFormState) {
        if (createNewTaskFormState.task.taskName?.getOrCrash() == '' ||
            createNewTaskFormState.task.taskName?.getOrCrash() == null) {
          return DisabledBtn(text: S.of(context).save, fixedSize: true);
        }
        return ElevatedButton(
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(
                Size.fromWidth(MediaQuery.of(context).size.width * 0.30)),
          ),
          onPressed: () => onPressedSaveBtn(context),
          child: Text(createNewTaskFormState.isEditing
              ? S.of(context).update
              : S.of(context).save),
        );
      },
    );
  }
}
