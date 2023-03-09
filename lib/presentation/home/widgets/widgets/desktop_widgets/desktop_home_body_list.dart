import 'package:flutter/material.dart';
import 'package:todo_board/presentation/home/widgets/widgets/desktop_widgets/desktop_timer.dart';
import 'package:todo_board/presentation/home/widgets/widgets/desktop_widgets/desktop_todo_and_in_progress.dart';
import 'package:todo_board/presentation/home/widgets/widgets/done_widget.dart';

class DesktopHomeBodyList extends StatelessWidget {
  const DesktopHomeBodyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        DesktopTimer(),
        DesktopToDoAndInProgress(),
        DoneWidget(),
      ],
    );
  }
}
