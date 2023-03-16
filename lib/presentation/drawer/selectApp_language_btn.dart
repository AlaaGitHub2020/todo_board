import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:todo_board/generated/l10n.dart';
import 'package:todo_board/main.dart';
import 'package:todo_board/presentation/routes/router.gr.dart';

class SelectAppLanguageBtn extends StatelessWidget {
  const SelectAppLanguageBtn({Key? key}) : super(key: key);

  onTapSelectAppLanguageBtn(BuildContext context) async {
    log.i("onTapSelectAppLanguageBtn Started");
    context.router.push(const AppLanguageRoute());
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      onTap: () => onTapSelectAppLanguageBtn(context),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20,bottom: 20,left: 10,right: 10),
            child: Text(
              S.of(context).language,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
