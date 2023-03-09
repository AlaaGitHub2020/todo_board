import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_board/application/task_timer/task_timer_bloc.dart';
import 'package:todo_board/application/tasks/task_actor/task_actor_bloc.dart';
import 'package:todo_board/application/tasks/tasks_watcher/tasks_watcher_bloc.dart';
import 'package:todo_board/domain/core/utilities/colors.dart';
import 'package:todo_board/domain/core/utilities/strings.dart';
import 'package:todo_board/injection.dart';
import 'package:todo_board/presentation/drawer/app_drawer.dart';
import 'package:todo_board/presentation/home/task_timer/task_timer.dart';
import 'package:todo_board/presentation/home/widgets/widgets/home_body.dart';
import 'package:todo_board/presentation/routes/router.gr.dart';

import '../../main.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  onPressAddTask(BuildContext context) {
    log.i("onPressAddTask Started");
    context.router.push(NewTaskRoute());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TasksWatcherBloc>(
          create: (context) => getIt<TasksWatcherBloc>()
            ..add(const TasksWatcherEvent.watchAllTasksStarted()),
        ),
        BlocProvider<TaskTimerBloc>(
            create: (context) => getIt<TaskTimerBloc>()),
        BlocProvider<TaskActorBloc>(
          create: (context) => getIt<TaskActorBloc>(),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.purpleColor1,
        appBar: buildAppBar(context),
        body: buildBody(),
        drawer: const AppDrawer(),
      ),
    );
  }

  Stack buildBody() {
    return Stack(
        children: const [
          HomeBody(),
          TaskTimer(),
        ],
      );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: null,
      title: Text(
        Strings.appTitle,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: AppColors.whiteColor1),
      ),
      centerTitle: false,
      actions: [
        IconButton(
            onPressed: () => onPressAddTask(context),
            icon: Icon(
              Icons.add,
              color: AppColors.whiteColor1,
            )),
      ],
    );
  }
}
