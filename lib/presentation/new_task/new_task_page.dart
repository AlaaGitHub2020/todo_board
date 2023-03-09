import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_board/application/tasks/create_new_task_form/create_new_task_form_bloc.dart';
import 'package:todo_board/domain/task/task_item.dart';
import 'package:todo_board/generated/l10n.dart';
import 'package:todo_board/injection.dart';
import 'package:todo_board/presentation/core/snackbars.dart';
import 'package:todo_board/presentation/new_task/widgets/create_new_task_body.dart';
import 'package:todo_board/presentation/new_task/widgets/saving_in_progress_overlay.dart';

class NewTaskPage extends StatelessWidget {
  final TaskItem? editedTask;

  const NewTaskPage({Key? key, this.editedTask}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CreateNewTaskFormBloc>()
        ..add(
          CreateNewTaskFormEvent.initialized(optionOf(editedTask)),
        ),
      child: BlocConsumer<CreateNewTaskFormBloc, CreateNewTaskFormState>(
        listenWhen: (previousState, currentState) =>
            previousState.saveFailureOrSuccessOption !=
            currentState.saveFailureOrSuccessOption,
        listener: (context, state) {
          state.saveFailureOrSuccessOption.fold(
            () => null,
            (either) => either.fold(
              (failure) => SnackBars.showError(
                  context,
                  failure.map(
                    unexpected: (_) => S.of(context).unexpected,
                    platFormServerFailure: (_) =>
                        S.of(context).platFormServerFailure,
                    insufficientPermission: (_) =>
                        S.of(context).insufficientPermission,
                    unableToUpdate: (_) => S.of(context).unableToUpdate,
                    taskIsEmptyPleaseFillItFirst: (_) =>
                        S.of(context).taskIsEmptyPleaseFillItFirst,
                  )),
              (_) {
                context.router.pop();
              },
            ),
          );
        },
        buildWhen: (previousState, currentState) =>
            previousState.isSaving != currentState.isSaving,
        builder: (context, state) {
          return Stack(
            children: [
              const CreateNewTaskBody(),
              SavingInProgressOverlay(isSaving: state.isSaving),
            ],
          );
        },
      ),
    );
  }
}
