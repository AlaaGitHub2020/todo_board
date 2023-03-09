import 'package:flutter/material.dart';
import 'package:todo_board/presentation/home/widgets/widgets/done_widget.dart';
import 'package:todo_board/presentation/home/widgets/widgets/in_progress_widget.dart';
import 'package:todo_board/presentation/home/widgets/widgets/mobile_widgets/mobile_timer.dart';
import 'package:todo_board/presentation/home/widgets/widgets/todo_widget.dart';

class MobileHomeBodyList extends StatelessWidget {
  const MobileHomeBodyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      primary: true,
      shrinkWrap: true,
      slivers: [
        MobileTimer(),
        ToDoWidget(),
        InProgressWidget(),
        DoneWidget(),
      ],
    );
  }
}
