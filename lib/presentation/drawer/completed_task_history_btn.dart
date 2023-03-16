import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:todo_board/generated/l10n.dart';
import 'package:todo_board/presentation/routes/router.gr.dart';

import '../../../main.dart';

class CompletedTaskHistoryBtn extends StatelessWidget {
  const CompletedTaskHistoryBtn({Key? key}) : super(key: key);

  onTapCompletedTaskHistoryBtn(BuildContext context) async {
    log.i("onTapCompletedTaskHistoryBtn Started");
    context.router.push(const CompletedTaskHistoryRoute());
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      onTap: () => onTapCompletedTaskHistoryBtn(context),
      child: Padding(
        padding: const EdgeInsets.only(top: 20,bottom: 20,left: 10,right: 10),
        child: Text(
          S.of(context).completedTaskHistory,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
