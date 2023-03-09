import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_board/application/tasks/create_new_task_form/create_new_task_form_bloc.dart';
import 'package:todo_board/domain/core/utilities/colors.dart';
import 'package:todo_board/generated/l10n.dart';
import 'package:todo_board/presentation/new_task/widgets/create_new_task_form.dart';

class CreateNewTaskBody extends StatelessWidget {
  const CreateNewTaskBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: buildAppBar(context),
      body: const CreateNewTaskForm(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: BlocBuilder<CreateNewTaskFormBloc, CreateNewTaskFormState>(
        buildWhen: (previousState, currentState) =>
            previousState.isEditing != currentState.isEditing,
        builder: (context, state) {
          return Text(
            state.isEditing
                ? S.of(context).editTask
                : S.of(context).createATask,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: AppColors.whiteColor1),
          );
        },
      ),
      centerTitle: false,
    );
  }
}
