import 'package:flutter/material.dart';
import 'package:todo_board/domain/core/utilities/colors.dart';
import 'package:todo_board/generated/l10n.dart';
import 'package:todo_board/presentation/app_language/widgets/language_body.dart';

class AppLanguagePage extends StatelessWidget {
  const AppLanguagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: Text(
            S.of(context).selectApplicationLanguage,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith( color: AppColors.whiteColor1),
          ),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          centerTitle: false,
        ),
        body: const LanguageBody(),
      ),
    );
  }
}
