import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_board/application/task_timer/task_timer_bloc.dart';

class MobileTimer extends StatelessWidget {
  const MobileTimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<TaskTimerBloc, TaskTimerState>(
        builder: (context, state) {
          return state.maybeMap(
            orElse: () => Container(),
            timerWorking: (taskItemWorkingOn) =>
                SizedBox(height: MediaQuery.of(context).size.height*0.09,),
          );
        },
      ),
    );
  }
}
