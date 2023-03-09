import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_board/application/tasks/create_new_task_form/create_new_task_form_bloc.dart';
import 'package:todo_board/presentation/new_task/widgets/cancel_btn.dart';
import 'package:todo_board/presentation/new_task/widgets/save_btn.dart';
import 'package:todo_board/presentation/new_task/widgets/select_task_priority_row_controllers.dart';
import 'package:todo_board/presentation/new_task/widgets/select_task_state_row_controllers.dart';
import 'package:todo_board/presentation/new_task/widgets/task_description_field.dart';
import 'package:todo_board/presentation/new_task/widgets/task_description_text.dart';
import 'package:todo_board/presentation/new_task/widgets/task_name_field.dart';
import 'package:todo_board/presentation/new_task/widgets/task_name_text.dart';

class CreateNewTaskForm extends StatelessWidget {
  const CreateNewTaskForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateNewTaskFormBloc, CreateNewTaskFormState>(
      buildWhen: (previousState, currentState) =>
          (previousState.showErrorMessages != currentState.showErrorMessages),
      builder: (context, state) {
        return Form(
          autovalidateMode: state.showErrorMessages,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TaskNameText(),
                  const SizedBox(height: 15),
                  const TaskNameField(),
                  const SizedBox(height: 15),
                  const TaskDescriptionText(),
                  const SizedBox(height: 15),
                  const TaskDescriptionField(),
                  const SizedBox(height: 15),
                  const SelectTaskPriorityRowControllers(),
                  const SizedBox(height: 15),
                  const SelectTaskStateRowControllers(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  buildBtnRow(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Row buildBtnRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        CancelBtn(),
        SaveBtn(),
      ],
    );
  }
}
