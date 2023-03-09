import 'package:flutter/material.dart';
import 'package:todo_board/presentation/home/widgets/widgets/in_progress_widget.dart';
import 'package:todo_board/presentation/home/widgets/widgets/todo_widget.dart';
import 'package:todo_board/presentation/home/widgets/widgets/two_side_sliver.dart';

class DesktopToDoAndInProgress extends StatelessWidget {
  const DesktopToDoAndInProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(
      builder: (context, constraints) {
        return TwoSideSliver(
          leftSize: constraints.crossAxisExtent * 0.5,
          left: const ToDoWidget(),
          right: const InProgressWidget(),
        );
      },
    );
  }
}
